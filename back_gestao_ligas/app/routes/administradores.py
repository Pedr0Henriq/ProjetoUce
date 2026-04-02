from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.models import Campeonato, Usuario
from app import db

administradores_bp = Blueprint('administradores', __name__)

def is_admin(usuario_id):
    usuario = Usuario.query.get(usuario_id)
    return usuario and usuario.perfil == 'ADMIN'

def is_campeonato_admin(usuario_id, campeonato):
    """Verifica se o usuário é super admin global E gerencia este campeonato especifico."""
    if not is_admin(usuario_id):
        return False
    # Verifica se ele tá na lista de controle daquele campeonato
    usuario = Usuario.query.get(usuario_id)
    return usuario in campeonato.administradores

@administradores_bp.route('/campeonatos/<int:campeonato_id>/administradores', methods=['GET'])
@jwt_required()
def listar_administradores(campeonato_id):
    """Retorna os administradores responsáveis por um campeonato (RF17)."""
    usuario_id_logado = get_jwt_identity()
    if not is_admin(usuario_id_logado):
        return jsonify({"erro": "Acesso negado."}), 403

    campeonato = Campeonato.query.get_or_404(campeonato_id)
    
    lista = []
    for admin in campeonato.administradores:
        lista.append({
            "usuario_id": admin.id,
            "nome": admin.nome,
            "email": admin.email
        })
        
    return jsonify(lista), 200

@administradores_bp.route('/campeonatos/<int:campeonato_id>/administradores', methods=['POST'])
@jwt_required()
def adicionar_administrador(campeonato_id):
    """Bônus: Adiciona um novo administrador a um campeonato."""
    usuario_id_logado = get_jwt_identity()
    if not is_admin(usuario_id_logado):
        return jsonify({"erro": "Acesso negado."}), 403

    campeonato = Campeonato.query.get_or_404(campeonato_id)
    
    dados = request.get_json()
    if not dados or 'usuario_id' not in dados:
        return jsonify({"erro": "Parâmetro usuario_id é obrigatório."}), 400
        
    novo_admin = Usuario.query.get_or_404(dados['usuario_id'])
    
    if novo_admin.perfil != 'ADMIN':
        return jsonify({"erro": "O usuário selecionado não possui permissões globais de ADMIN."}), 400
        
    if novo_admin in campeonato.administradores:
        return jsonify({"erro": "O usuário já é administrador deste campeonato."}), 400
        
    campeonato.administradores.append(novo_admin)
    db.session.commit()
    
    return jsonify({"mensagem": "Administrador vinculado com sucesso."}), 201
