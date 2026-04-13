from flask import Blueprint, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity

from app import db
from app.models import Usuario

usuarios_bp = Blueprint('usuarios', __name__)


def _is_admin_global(usuario_id):
    usuario = Usuario.query.get(usuario_id)
    return usuario is not None and bool(usuario.ativo) and usuario.perfil == 'ADMIN'


@usuarios_bp.route('/usuarios', methods=['GET'])
@jwt_required()
def listar_usuarios():
    """Lista usuários para gestão administrativa.

    Apenas administradores globais podem acessar.
    """
    usuario_id_logado = get_jwt_identity()
    if not _is_admin_global(usuario_id_logado):
        return jsonify({'erro': 'Acesso negado. Apenas administradores podem listar usuários.'}), 403

    usuarios = Usuario.query.all()
    usuarios.sort(
        key=lambda u: (
            not bool(u.ativo),
            u.perfil != 'ADMIN',
            (u.nome or '').lower(),
        )
    )

    return jsonify([u.to_dict() for u in usuarios]), 200


@usuarios_bp.route('/usuarios/<int:usuario_id>/promover', methods=['POST'])
@jwt_required()
def promover_usuario(usuario_id):
    """Promove usuário ativo para ADMIN global."""
    usuario_id_logado = get_jwt_identity()
    if not _is_admin_global(usuario_id_logado):
        return jsonify({'erro': 'Acesso negado. Apenas administradores podem promover usuários.'}), 403

    usuario = Usuario.query.get_or_404(usuario_id)

    if not usuario.ativo:
        return jsonify({'erro': 'Não é possível promover um usuário desativado.'}), 400

    if usuario.perfil == 'ADMIN':
        return jsonify({'erro': 'Este usuário já possui perfil ADMIN.'}), 400

    usuario.perfil = 'ADMIN'
    db.session.commit()

    return jsonify({
        'mensagem': 'Usuário promovido para ADMIN com sucesso.',
        'usuario': usuario.to_dict(),
    }), 200


@usuarios_bp.route('/usuarios/<int:usuario_id>/desativar', methods=['POST'])
@jwt_required()
def desativar_usuario(usuario_id):
    """Desativa um usuário sem removê-lo da base (soft-disable)."""
    usuario_id_logado = get_jwt_identity()
    if not _is_admin_global(usuario_id_logado):
        return jsonify({'erro': 'Acesso negado. Apenas administradores podem desativar usuários.'}), 403

    if str(usuario_id) == str(usuario_id_logado):
        return jsonify({'erro': 'Você não pode desativar sua própria conta.'}), 400

    usuario = Usuario.query.get_or_404(usuario_id)

    if not usuario.ativo:
        return jsonify({'erro': 'Este usuário já está desativado.'}), 400

    if usuario.perfil == 'ADMIN':
        total_admins_ativos = Usuario.query.filter_by(perfil='ADMIN', ativo=True).count()
        if total_admins_ativos <= 1:
            return jsonify({'erro': 'Não é possível desativar o último administrador ativo do sistema.'}), 400

    usuario.ativo = False
    db.session.commit()

    return jsonify({
        'mensagem': 'Usuário desativado com sucesso.',
        'usuario': usuario.to_dict(),
    }), 200


@usuarios_bp.route('/usuarios/<int:usuario_id>/reativar', methods=['POST'])
@jwt_required()
def reativar_usuario(usuario_id):
    """Reativa um usuário previamente desativado."""
    usuario_id_logado = get_jwt_identity()
    if not _is_admin_global(usuario_id_logado):
        return jsonify({'erro': 'Acesso negado. Apenas administradores podem reativar usuários.'}), 403

    usuario = Usuario.query.get_or_404(usuario_id)

    if usuario.ativo:
        return jsonify({'erro': 'Este usuário já está ativo.'}), 400

    usuario.ativo = True
    db.session.commit()

    return jsonify({
        'mensagem': 'Usuário reativado com sucesso.',
        'usuario': usuario.to_dict(),
    }), 200
