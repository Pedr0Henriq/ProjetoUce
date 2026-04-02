from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.models import Time, Campeonato, Usuario
from app import db

times_bp = Blueprint('times', __name__)

from app.routes.administradores import is_campeonato_admin

@times_bp.route('/campeonatos/<int:campeonato_id>/times', methods=['GET'])
@jwt_required()
def listar_times_campeonato(campeonato_id):
    """Lista todos os times de um campeonato (RF05)."""
    # Valida se o campeonato existe (se não existir, retorna 404 sozinho)
    campeonato = Campeonato.query.get_or_404(campeonato_id)
    
    return jsonify([t.to_dict() for t in campeonato.times]), 200

@times_bp.route('/campeonatos/<int:campeonato_id>/times', methods=['POST'])
@jwt_required()
def criar_time(campeonato_id):
    """Cadastra um time em um campeonato (RF05)."""
    campeonato = Campeonato.query.get_or_404(campeonato_id)
    usuario_id = get_jwt_identity()
    if not is_campeonato_admin(usuario_id, campeonato):
        return jsonify({"erro": "Acesso negado. Apenas administradores do campeonato podem gerenciar times."}), 403
    dados = request.get_json()
    
    if not dados or 'nome' not in dados or 'localidade' not in dados:
        return jsonify({"erro": "Nome e localidade são obrigatórios"}), 400

    novo_time = Time(
        nome=dados['nome'],
        localidade=dados['localidade'],
        escudo_url=dados.get('escudo_url'),
        campeonato_id=campeonato_id
    )

    db.session.add(novo_time)
    db.session.commit()

    return jsonify(novo_time.to_dict()), 201

@times_bp.route('/times/<int:id>', methods=['GET'])
@jwt_required()
def obter_time(id):
    """Retorna a ficha completa de um time com estatísticas (RF05, RF10, RF13)."""
    time = Time.query.get_or_404(id)
    
    time_data = time.to_dict()
    
    from app.routes.estatisticas import calcular_stats_base
    stats_dict = calcular_stats_base(time.campeonato_id)
    lista = list(stats_dict.values())
    
    lista_ordenada = sorted(
        lista, 
        key=lambda k: (k['pontos'], k['vitorias'], k['saldo'], k['gols_pro']), 
        reverse=True
    )
    
    time_data["estatisticas"] = {
        "jogos": 0, "vitorias": 0, "empates": 0, "derrotas": 0,
        "gols_pro": 0, "gols_contra": 0, "saldo": 0, "pontos": 0, "posicao": 0
    }
    
    for index, obj in enumerate(lista_ordenada):
        if obj['time']['id'] == id:
            obj_clean = obj.copy()
            del obj_clean['time']
            obj_clean['posicao'] = index + 1
            time_data["estatisticas"] = obj_clean
            break
    
    return jsonify(time_data), 200

@times_bp.route('/times/<int:id>', methods=['PUT'])
@jwt_required()
def atualizar_time(id):
    """Atualiza os dados de um time (RF05)."""
    time = Time.query.get_or_404(id)
    usuario_id = get_jwt_identity()
    if not is_campeonato_admin(usuario_id, time.campeonato):
        return jsonify({"erro": "Acesso negado."}), 403
    dados = request.get_json()
    
    if 'nome' in dados:
        time.nome = dados['nome']
    if 'localidade' in dados:
        time.localidade = dados['localidade']
    if 'escudo_url' in dados:
        time.escudo_url = dados['escudo_url']
        
    db.session.commit()

    return jsonify(time.to_dict()), 200

@times_bp.route('/times/<int:id>', methods=['DELETE'])
@jwt_required()
def deletar_time(id):
    """Remove um time (RF05)."""
    time = Time.query.get_or_404(id)
    usuario_id = get_jwt_identity()
    if not is_campeonato_admin(usuario_id, time.campeonato):
        return jsonify({"erro": "Acesso negado."}), 403
    
    # Verifica se há partidas criadas e finalizadas que envolvam o time
    from app.models import Partida
    partidas_finalizadas = Partida.query.filter(
        ((Partida.time_mandante_id == id) | (Partida.time_visitante_id == id)) &
        (Partida.status == 'FINALIZADA')
    ).first()
    
    if partidas_finalizadas:
        return jsonify({"erro": "Não é possível excluir um time que já possui partidas finalizadas."}), 400
    
    db.session.delete(time)
    db.session.commit()

    return '', 204
