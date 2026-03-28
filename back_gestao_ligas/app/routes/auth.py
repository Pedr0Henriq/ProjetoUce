from flask import Blueprint, request, jsonify
from flask_jwt_extended import create_access_token
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