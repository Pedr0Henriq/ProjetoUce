import re
from flask import Blueprint, request, jsonify
from flask_jwt_extended import create_access_token, jwt_required, get_jwt_identity, decode_token
from datetime import timedelta
from app.models import Usuario
from app import db

# Padrão simples para validação de formato de e-mail
_EMAIL_RE = re.compile(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
_SENHA_MIN_LEN = 6


def _normalizar_perfil_cadastro(perfil_raw):
    """Normaliza o perfil aceito no cadastro público.

    Regras:
    - Ausente ou aliases de visualização => VIEWER
    - ADMIN é proibido no cadastro público
    - Demais valores são inválidos
    """
    if perfil_raw is None:
        return 'VIEWER'

    perfil = str(perfil_raw).strip().upper()
    if perfil in ('', 'VIEWER', 'ANALISTA', 'VISUALIZADOR'):
        return 'VIEWER'
    if perfil == 'ADMIN':
        raise ValueError('Cadastro público não permite perfil ADMIN.')
    raise ValueError('Perfil inválido para cadastro público.')

# Criamos o Blueprint para as rotas de autenticação
auth_bp = Blueprint('auth', __name__)

@auth_bp.route('/register', methods=['POST'])
def register():
    dados = request.get_json(silent=True) or {}

    nome = str(dados.get('nome', '')).strip()
    email = str(dados.get('email', '')).strip().lower()
    senha = dados.get('senha')
    
    # Validação básica para não quebrar o banco se faltarem dados essenciais
    if not nome or not email or senha is None:
        return jsonify({"erro": "Nome, e-mail e senha são obrigatórios"}), 400

    if not _EMAIL_RE.match(email):
        return jsonify({"erro": "Formato de e-mail inválido."}), 400

    if not isinstance(senha, str) or not senha.strip():
        return jsonify({"erro": "Senha é obrigatória."}), 400

    if len(senha) < _SENHA_MIN_LEN:
        return jsonify({"erro": f"A senha deve ter no mínimo {_SENHA_MIN_LEN} caracteres."}), 400

    # Verifica se o e-mail já existe no banco
    if Usuario.query.filter_by(email=email).first():
        return jsonify({"erro": "E-mail já cadastrado"}), 400

    try:
        perfil = _normalizar_perfil_cadastro(dados.get('perfil'))
    except ValueError as exc:
        return jsonify({"erro": str(exc)}), 400
        
    # Cadastro público sempre cria usuário com perfil de visualização.
    novo_usuario = Usuario(
        nome=nome,
        email=email,
        perfil=perfil,
    )
    
    # Usa o método que criamos para gerar o hash da senha de forma segura
    novo_usuario.set_senha(dados.get('senha'))
    
    db.session.add(novo_usuario)
    db.session.commit()
    
    # Retorna o status 201 (Created) e os dados do usuário
    return jsonify(novo_usuario.to_dict()), 201

@auth_bp.route('/login', methods=['POST'])
def login():
    dados = request.get_json()
    
    if not dados or not dados.get('email') or not dados.get('senha'):
        return jsonify({"erro": "E-mail e senha são obrigatórios"}), 400

    email = dados.get('email')
    senha_plana = dados.get('senha')
    
    # Busca o usuário pelo e-mail
    usuario = Usuario.query.filter_by(email=email).first()
    
    # Verifica se o usuário existe e compara a senha recebida com o hash salvo
    if not usuario or not usuario.verificar_senha(senha_plana):
        return jsonify({"erro": "E-mail ou senha inválidos"}), 401
        
    # Cria o token JWT (configurado para expirar em 1 hora, ou 3600 segundos)
    tempo_expiracao = timedelta(hours=1)
    
    # É uma boa prática usar uma string como identidade (o ID do usuário)
    access_token = create_access_token(identity=str(usuario.id), expires_delta=tempo_expiracao)
    
    # Monta a resposta exatamente como pedida na documentação
    return jsonify({
        "access_token": access_token,
        "token_type": "Bearer",
        "expires_in": 3600,
        "usuario": usuario.to_dict()
    }), 200

@auth_bp.route('/refresh', methods=['POST'])
@jwt_required()
def refresh():
    # Pega a identidade do usuário a partir do token atual
    usuario_id = str(get_jwt_identity())
    
    # Gera um novo token com expiração renovada
    tempo_expiracao = timedelta(hours=1)
    novo_token = create_access_token(identity=usuario_id, expires_delta=tempo_expiracao)
    
    return jsonify({
        "access_token": novo_token,
        "expires_in": 3600
    }), 200

@auth_bp.route('/forgot-password', methods=['POST'])
def forgot_password():
    dados = request.get_json()
    if not dados:
        return jsonify({"erro": "E-mail é obrigatório"}), 400
        
    email = dados.get('email')
    
    if not email:
        return jsonify({"erro": "E-mail é obrigatório"}), 400
        
    usuario = Usuario.query.filter_by(email=email).first()
    
    if usuario:
        # Gera um token JWT temporário para reset de senha (válido por 15 min)
        reset_token = create_access_token(
            identity=str(usuario.id),
            expires_delta=timedelta(minutes=15),
            additional_claims={"tipo": "reset_password"}
        )
        # Simulando o envio de e-mail imprimindo no console
        # print(f"\n--- SIMULAÇÃO DE E-MAIL ---", flush=True)
        # print(f"Para redefinir a senha de {usuario.nome}, use o token:", flush=True)
        # print(f"{reset_token}", flush=True)
        # print(f"---------------------------\n", flush=True)
        
    # Sempre retornamos a mesma mensagem p/ não expor quais e-mails existem no sistema
    return jsonify({
        "mensagem": "Se o e-mail existir, um link de recuperação foi enviado."
    }), 200

@auth_bp.route('/reset-password', methods=['POST'])
def reset_password():
    dados = request.get_json()
    if not dados:
        return jsonify({"erro": "Token e nova senha são obrigatórios"}), 400
        
    token = dados.get('token')
    nova_senha = dados.get('nova_senha')
    
    if not token or not nova_senha:
        return jsonify({"erro": "Token e nova_senha são obrigatórios"}), 400
        
    try:
        # Decodifica e valida o token manualmente
        # O Flask-JWT lança erro caso esteja expirado ou inválido
        token_decodificado = decode_token(token)
        
        # Confere se é um token exclusivo para reset
        if token_decodificado.get("tipo") != "reset_password":
            return jsonify({"erro": "Token inválido para redefinição de senha."}), 400
            
        usuario_id = int(token_decodificado["sub"])
        usuario = Usuario.query.get(usuario_id)
        
        if not usuario:
            return jsonify({"erro": "Usuário não encontrado."}), 404
            
        # Altera a senha
        usuario.set_senha(nova_senha)
        db.session.commit()
        
        return jsonify({"mensagem": "Senha redefinida com sucesso."}), 200
        
    except Exception as e:
        return jsonify({"erro": "Token inválido ou expirado."}), 400

@auth_bp.route('/me', methods=['GET'])
@jwt_required()
def me():
    usuario_id = get_jwt_identity()
    usuario = Usuario.query.get(usuario_id)
    
    if not usuario:
        return jsonify({"erro": "Usuário não encontrado."}), 404
        
    return jsonify(usuario.to_dict()), 200

@auth_bp.route('/me', methods=['PUT'])
@jwt_required()
def update_me():
    usuario_id = get_jwt_identity()
    usuario = Usuario.query.get(usuario_id)
    
    if not usuario:
        return jsonify({"erro": "Usuário não encontrado."}), 404
        
    dados = request.get_json()
    if not dados:
        return jsonify({"erro": "Nenhum dado enviado."}), 400
        
    # Atualiza o nome, se vier
    if 'nome' in dados:
        usuario.nome = dados['nome']
        
    # Atualiza email se vier e for diferente, e se não tiver duplicado
    if 'email' in dados and dados['email'] != usuario.email:
        if not _EMAIL_RE.match(dados['email']):
            return jsonify({"erro": "Formato de e-mail inválido."}), 400
        existente = Usuario.query.filter_by(email=dados['email']).first()
        if existente:
            return jsonify({"erro": "Este e-mail já está em uso por outra conta."}), 409
        usuario.email = dados['email']
        
    # Atualiza a senha (requer enviar senha_atual e nova_senha)
    senha_atual = dados.get('senha_atual')
    nova_senha = dados.get('nova_senha')
    
    if senha_atual and nova_senha:
        if not usuario.verificar_senha(senha_atual):
            return jsonify({"erro": "A senha atual está incorreta."}), 400
        usuario.set_senha(nova_senha)

    db.session.commit()
    return jsonify(usuario.to_dict()), 200


# ── Aliases de compatibilidade com o app móvel Flutter ────────────────────────
# O frontend chama /perfil e /recuperar-senha; mantemos /me e /forgot-password
# como rotas canônicas e criamos aliases para não depender de uma nova build.

@auth_bp.route('/perfil', methods=['GET'])
@jwt_required()
def get_perfil():
    """Alias de GET /me para compatibilidade com o app móvel."""
    return me()


@auth_bp.route('/perfil', methods=['PUT'])
@jwt_required()
def update_perfil():
    """Alias de PUT /me para compatibilidade com o app móvel."""
    return update_me()


@auth_bp.route('/recuperar-senha', methods=['POST'])
def recuperar_senha():
    """Alias de POST /forgot-password para compatibilidade com o app móvel."""
    return forgot_password()


@auth_bp.route('/logout', methods=['POST'])
@jwt_required()
def logout():
    """Encerra a sessão do usuário.

    JWT é stateless: a invalidação real ocorre no cliente descartando o token.
    Este endpoint existe para que o app possa registrar a intenção de logout e
    receber uma confirmação explícita (útil para analytics e auditoria futura).
    """
    return jsonify({"mensagem": "Sessão encerrada com sucesso."}), 200