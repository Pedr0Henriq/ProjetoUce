from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.models import Jogador, Time, Campeonato, Usuario
from app import db


jogadores_bp = Blueprint('jogadores', __name__)

from app.routes.administradores import is_campeonato_admin

@jogadores_bp.route('/times/<int:time_id>/jogadores', methods=['GET'])
@jwt_required()
def listar_jogadores_time(time_id):
    """Lista todos os jogadores de um time (RF06)."""
    # Valida se o time existe
    time = Time.query.get_or_404(time_id)
    
    # Retorna usando o relacionamento cascata
    return jsonify([j.to_dict() for j in time.jogadores]), 200

@jogadores_bp.route('/times/<int:time_id>/jogadores', methods=['POST'])
@jwt_required()
def criar_jogador(time_id):
    """Cadastra um jogador em um time (RF06)."""
    time = Time.query.get_or_404(time_id)
    usuario_id = get_jwt_identity()
    if not is_campeonato_admin(usuario_id, time.campeonato):
        return jsonify({"erro": "Acesso negado."}), 403
    dados = request.get_json()
    
    # Validação básica
    if not dados or 'nome' not in dados or 'numero' not in dados or 'posicao' not in dados:
        return jsonify({"erro": "Nome, número e posição são obrigatórios."}), 400

    novo_jogador = Jogador(
        nome=dados['nome'],
        numero=dados['numero'],
        posicao=dados['posicao'],
        time_id=time_id
    )

    db.session.add(novo_jogador)
    db.session.commit()

    return jsonify(novo_jogador.to_dict()), 201

@jogadores_bp.route('/jogadores/<int:id>', methods=['PUT'])
@jwt_required()
def atualizar_jogador(id):
    """Atualiza os dados de um jogador (RF06)."""
    jogador = Jogador.query.get_or_404(id)
    usuario_id = get_jwt_identity()
    if not is_campeonato_admin(usuario_id, jogador.time.campeonato):
        return jsonify({"erro": "Acesso negado."}), 403
    dados = request.get_json()
    
    if not dados:
        return jsonify({"erro": "Nenhum dado enviado."}), 400
        
    if 'nome' in dados:
        jogador.nome = dados['nome']
    if 'numero' in dados:
        jogador.numero = dados['numero']
    if 'posicao' in dados:
        jogador.posicao = dados['posicao']
        
    db.session.commit()

    return jsonify(jogador.to_dict()), 200

@jogadores_bp.route('/jogadores/<int:id>', methods=['DELETE'])
@jwt_required()
def deletar_jogador(id):
    """Remove um jogador (RF06)."""
    jogador = Jogador.query.get_or_404(id)
    usuario_id = get_jwt_identity()
    if not is_campeonato_admin(usuario_id, jogador.time.campeonato):
        return jsonify({"erro": "Acesso negado."}), 403
    
    # Verifica se o jogador tem eventos em partidas finalizadas
    from app.models import EventoPartida, Partida
    eventos_finalizados = EventoPartida.query.join(Partida).filter(
        (EventoPartida.jogador_id == id) & (Partida.status == 'FINALIZADA')
    ).first()
    
    if eventos_finalizados:
        return jsonify({"erro": "Não é possível excluir um jogador com eventos em uma partida já finalizada."}), 400

    db.session.delete(jogador)
    db.session.commit()

    return '', 204
