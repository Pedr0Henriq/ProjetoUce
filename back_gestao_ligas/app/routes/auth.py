from flask import Blueprint, request, jsonify
from flask_jwt_extended import create_access_token, jwt_required, get_jwt_identity, decode_token
from datetime import timedelta
from app.models import Usuario
from app import db

# Criamos o Blueprint para as rotas de autenticação
auth_bp = Blueprint('auth', __name__)

@auth_bp.route('/register', methods=['POST'])
def register():
    dados = request.get_json()
    
    # Validação básica para não quebrar o banco se faltarem dados essenciais
    if not dados or not dados.get('nome') or not dados.get('email') or not dados.get('senha'):
        return jsonify({"erro": "Nome, e-mail e senha são obrigatórios"}), 400

    # Verifica se o e-mail já existe no banco
    if Usuario.query.filter_by(email=dados.get('email')).first():
        return jsonify({"erro": "E-mail já cadastrado"}), 400
        
    # Cria a instância do usuário (o perfil padrão será VIEWER se não for enviado)
    novo_usuario = Usuario(
        nome=dados.get('nome'),
        email=dados.get('email'),
        perfil=dados.get('perfil', 'VIEWER') 
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