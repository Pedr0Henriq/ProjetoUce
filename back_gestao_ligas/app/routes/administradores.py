from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.models import Campeonato, Usuario
from app import db

administradores_bp = Blueprint('administradores', __name__)


def _e_admin_global(usuario_id):
    """Retorna True se o usuário tiver perfil ADMIN global."""
    usuario = Usuario.query.get(usuario_id)
    return usuario is not None and usuario.perfil == 'ADMIN'


def is_campeonato_admin(usuario_id, campeonato):
    """Retorna True se o usuário for ADMIN global ou co-admin do campeonato."""
    if campeonato is None:
        return False

    usuario = Usuario.query.get(usuario_id)
    if usuario is None:
        return False

    if usuario.perfil == 'ADMIN':
        return True

    return any(str(admin.id) == str(usuario_id) for admin in campeonato.administradores)


@administradores_bp.route('/campeonatos/<int:campeonato_id>/administradores', methods=['GET'])
@jwt_required()
def listar_administradores(campeonato_id):
    """RF17 — Lista os co-administradores vinculados a um campeonato.

    Requer autenticação. Apenas administradores do campeonato podem acessar.

    Returns:
        200: Lista de objetos ``{"id", "nome", "email"}``.
        403: Usuário sem permissão de administrador.
        404: Campeonato não encontrado.
    """
    campeonato = Campeonato.query.get_or_404(campeonato_id)
    usuario_id_logado = get_jwt_identity()
    if not is_campeonato_admin(usuario_id_logado, campeonato):
        return jsonify({"erro": "Acesso negado."}), 403

    lista = [
        admin.to_dict()
        for admin in campeonato.administradores
    ]
    return jsonify(lista), 200


@administradores_bp.route('/campeonatos/<int:campeonato_id>/administradores', methods=['POST'])
@jwt_required()
def adicionar_administrador(campeonato_id):
    """RF17 — Vincula um usuário como co-administrador de um campeonato.

    Aceita ``{"email": "<email do usuário>"}`` no corpo da requisição.
    Qualquer usuário cadastrado pode ser adicionado — não é necessário que já
    seja ADMIN global; o vínculo é exclusivo deste campeonato.

    Returns:
        201: Administrador vinculado com sucesso (retorna o objeto do usuário).
        400: Parâmetro ausente ou usuário já é admin deste campeonato.
        403: Requisitante sem permissão de administrador do campeonato.
        404: Campeonato ou usuário com o e-mail fornecido não encontrado.
    """
    campeonato = Campeonato.query.get_or_404(campeonato_id)
    usuario_id_logado = get_jwt_identity()
    if not is_campeonato_admin(usuario_id_logado, campeonato):
        return jsonify({"erro": "Acesso negado."}), 403

    dados = request.get_json()
    if not dados or not dados.get('email'):
        return jsonify({"erro": "O campo 'email' é obrigatório."}), 400

    novo_admin = Usuario.query.filter_by(email=dados['email']).first()
    if not novo_admin:
        return jsonify({"erro": "Nenhum usuário com este e-mail foi encontrado."}), 404

    if novo_admin in campeonato.administradores:
        return jsonify({"erro": "O usuário já é administrador deste campeonato."}), 400

    campeonato.administradores.append(novo_admin)
    db.session.commit()

    return jsonify({
        "mensagem": "Administrador vinculado com sucesso.",
        "usuario": novo_admin.to_dict()
    }), 201


@administradores_bp.route(
    '/campeonatos/<int:campeonato_id>/administradores/<int:usuario_id>',
    methods=['DELETE']
)
@jwt_required()
def remover_administrador(campeonato_id, usuario_id):
    """RF17 — Remove o vínculo de co-administrador de um campeonato.

    O administrador solicitante não pode remover a si próprio, garantindo que
    o campeonato sempre tenha pelo menos um responsável.

    Returns:
        200: Vínculo removido com sucesso.
        400: Tentativa de auto-remoção.
        403: Requisitante sem permissão de administrador do campeonato.
        404: Campeonato, usuário ou vínculo não encontrado.
    """
    campeonato = Campeonato.query.get_or_404(campeonato_id)
    usuario_id_logado = get_jwt_identity()
    if not is_campeonato_admin(usuario_id_logado, campeonato):
        return jsonify({"erro": "Acesso negado."}), 403

    if str(usuario_id) == str(usuario_id_logado):
        return jsonify({"erro": "Você não pode remover a si mesmo como administrador."}), 400

    usuario = Usuario.query.get_or_404(usuario_id)

    if usuario not in campeonato.administradores:
        return jsonify({"erro": "Este usuário não é administrador deste campeonato."}), 404

    campeonato.administradores.remove(usuario)
    db.session.commit()

    return jsonify({"mensagem": "Administrador removido com sucesso."}), 200
