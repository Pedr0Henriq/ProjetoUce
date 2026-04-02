from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity
from datetime import datetime, timedelta
import random

from app.models import Partida, Campeonato, Time, Usuario, EventoPartida
from app import db

partidas_bp = Blueprint('partidas', __name__)

from app.routes.administradores import is_campeonato_admin

@partidas_bp.route('/campeonatos/<int:campeonato_id>/gerar-calendario', methods=['POST'])
@jwt_required()
def gerar_calendario(campeonato_id):
    """Gera automaticamente o calendário do campeonato (RF07)."""
    campeonato = Campeonato.query.get_or_404(campeonato_id)
    usuario_id = get_jwt_identity()
    if not is_campeonato_admin(usuario_id, campeonato):
        return jsonify({"erro": "Acesso negado."}), 403
    dados = request.get_json()

    if not dados or 'tipo_geracao' not in dados or 'data_primeira_rodada' not in dados:
        return jsonify({"erro": "Faltam parâmetros tipo_geracao ou data_primeira_rodada"}), 400

    tipo_geracao = dados['tipo_geracao']
    
    try:
        data_inicial = datetime.strptime(dados['data_primeira_rodada'], '%Y-%m-%d').date()
    except ValueError:
        return jsonify({"erro": "Formato de data inválido. Use YYYY-MM-DD"}), 400

    # Busca todos os times do campeonato
    times = Time.query.filter_by(campeonato_id=campeonato_id).all()
    if len(times) < 2:
        return jsonify({"erro": "É necessário no mínimo 2 times para gerar o calendário."}), 400

    partidas_geradas = []

    if tipo_geracao == 'PONTOS_CORRIDOS':
        times_ids = [t.id for t in times]
        if len(times_ids) % 2 != 0:
            times_ids.append(None) # Team fantasma "BYE"
            
        n = len(times_ids)
        
        for rodada_idx in range(n - 1):
            data_rodada = data_inicial + timedelta(days=7 * rodada_idx)
            
            for i in range(n // 2):
                mandante_id = times_ids[i]
                visitante_id = times_ids[n - 1 - i]
                
                # Se não contiver "BYE", a partida é real
                if mandante_id is not None and visitante_id is not None:
                    # Inversão pra alternar quem é mandante e visitante para justiça
                    if rodada_idx % 2 == 1:
                        mandante_id, visitante_id = visitante_id, mandante_id
                        
                    nova_partida = Partida(
                        campeonato_id=campeonato_id,
                        rodada=(rodada_idx + 1),
                        time_mandante_id=mandante_id,
                        time_visitante_id=visitante_id,
                        data=data_rodada,
                        status='AGENDADA'
                    )
                    db.session.add(nova_partida)
                    partidas_geradas.append(nova_partida)
                    
            # Rotacionar o array (mantendo o primeiro elemento fixo)
            times_ids = [times_ids[0]] + [times_ids[-1]] + times_ids[1:-1]
            
    elif tipo_geracao == 'ELIMINATORIA':
        # MATA-MATA OITAVAS/QUARTAS ETC 
        times_embaralhados = [t for t in times]
        random.shuffle(times_embaralhados)
        
        for i in range(0, len(times_embaralhados) - 1, 2):
            # Cria pares sequenciais
            t1 = times_embaralhados[i]
            t2 = times_embaralhados[i+1]
            nova_partida = Partida(
                campeonato_id=campeonato_id,
                rodada=1,
                time_mandante_id=t1.id,
                time_visitante_id=t2.id,
                data=data_inicial,
                status='AGENDADA'
            )
            db.session.add(nova_partida)
            partidas_geradas.append(nova_partida)

    else:
        return jsonify({"erro": "tipo_geracao não suportado."}), 400

    db.session.commit()

    return jsonify({
        "mensagem": "Calendário gerado com sucesso.",
        "total_partidas": len(partidas_geradas)
    }), 201

@partidas_bp.route('/campeonatos/<int:campeonato_id>/partidas', methods=['GET'])
@jwt_required()
def listar_partidas(campeonato_id):
    """Lista as partidas de um campeonato com filtros (RF08)."""
    # Verifica campeonato
    Campeonato.query.get_or_404(campeonato_id)
    
    query = Partida.query.filter_by(campeonato_id=campeonato_id)
    
    status = request.args.get('status')
    if status:
        query = query.filter(Partida.status == status.upper())
        
    rodada = request.args.get('rodada')
    if rodada:
        try:
            query = query.filter(Partida.rodada == int(rodada))
        except ValueError:
            pass

    partidas = query.all()
    return jsonify([p.to_dict() for p in partidas]), 200

@partidas_bp.route('/partidas/<int:id>', methods=['GET'])
@jwt_required()
def obter_partida(id):
    """Retorna os dados detalhados de uma partida específica (RF08)."""
    partida = Partida.query.get_or_404(id)
    return jsonify(partida.to_dict()), 200

@partidas_bp.route('/campeonatos/<int:campeonato_id>/partidas', methods=['POST'])
@jwt_required()
def criar_partida(campeonato_id):
    """Cria uma partida manualmente (RF08)."""
    campeonato = Campeonato.query.get_or_404(campeonato_id)
    usuario_id = get_jwt_identity()
    if not is_campeonato_admin(usuario_id, campeonato):
        return jsonify({"erro": "Acesso negado."}), 403
    dados = request.get_json()
    
    obrigatorios = ['rodada', 'time_mandante_id', 'time_visitante_id']
    if not dados or not all(campo in dados for campo in obrigatorios):
        return jsonify({"erro": "Parâmetros incompletos"}), 400

    data_obj = None
    if 'data' in dados:
        try:
            data_obj = datetime.strptime(dados['data'], '%Y-%m-%d').date()
        except ValueError:
            return jsonify({"erro": "Formato de data inválido. Use YYYY-MM-DD"}), 400

    nova_partida = Partida(
        campeonato_id=campeonato_id,
        rodada=dados['rodada'],
        time_mandante_id=dados['time_mandante_id'],
        time_visitante_id=dados['time_visitante_id'],
        data=data_obj,
        horario=dados.get('horario'),
        local=dados.get('local'),
        status='AGENDADA'
    )
    
    db.session.add(nova_partida)
    db.session.commit()
    return jsonify(nova_partida.to_dict()), 201

@partidas_bp.route('/partidas/<int:id>', methods=['PUT'])
@jwt_required()
def atualizar_partida(id):
    """Atualiza dados de uma partida (RF08)."""
    partida = Partida.query.get_or_404(id)
    usuario_id = get_jwt_identity()
    if not is_campeonato_admin(usuario_id, partida.campeonato_rel):
        return jsonify({"erro": "Acesso negado."}), 403
    
    if partida.status == 'FINALIZADA':
        return jsonify({"erro": "Não é permitido alterar uma partida FINALIZADA."}), 400
        
    dados = request.get_json()
    if not dados:
        return jsonify({"erro": "Nenhum dado enviado."}), 400

    if 'data' in dados:
        try:
            partida.data = datetime.strptime(dados['data'], '%Y-%m-%d').date()
        except ValueError:
            return jsonify({"erro": "Formato de data inválido. Use YYYY-MM-DD"}), 400
            
    if 'horario' in dados:
        partida.horario = dados['horario']
    if 'local' in dados:
        partida.local = dados['local']
    if 'status' in dados:
        partida.status = dados['status']

    db.session.commit()
    return jsonify(partida.to_dict()), 200

@partidas_bp.route('/partidas/<int:id>', methods=['DELETE'])
@jwt_required()
def deletar_partida(id):
    """Remove uma partida (RF08)."""
    partida = Partida.query.get_or_404(id)
    usuario_id = get_jwt_identity()
    if not is_campeonato_admin(usuario_id, partida.campeonato_rel):
        return jsonify({"erro": "Acesso negado."}), 403
    
    if partida.status == 'FINALIZADA':
        return jsonify({"erro": "Não é permitido apagar uma partida FINALIZADA."}), 400

    db.session.delete(partida)
    db.session.commit()
    return '', 204

@partidas_bp.route('/partidas/<int:id>/resultado', methods=['POST'])
@jwt_required()
def salvar_resultado(id):
    """Registra o placar e eventos de uma partida, definindo-a como FINALIZADA (RF04)."""
    partida = Partida.query.get_or_404(id)
    usuario_id = get_jwt_identity()
    if not is_campeonato_admin(usuario_id, partida.campeonato_rel):
        return jsonify({"erro": "Acesso negado."}), 403
    
    if partida.status == 'FINALIZADA':
        return jsonify({"erro": "Esta partida já foi finalizada."}), 400
        
    dados = request.get_json()
    if not dados or 'gols_mandante' not in dados or 'gols_visitante' not in dados:
        return jsonify({"erro": "Placares são obrigatórios (gols_mandante e gols_visitante)."}), 400

    partida.placar_mandante = dados['gols_mandante']
    partida.placar_visitante = dados['gols_visitante']
    partida.status = 'FINALIZADA'

    eventos_enviados = dados.get('eventos', [])
    for ev in eventos_enviados:
        novo_evento = EventoPartida(
            tipo=ev['tipo'],
            minuto=ev['minuto'],
            jogador_id=ev['jogador_id'],
            time_id=ev['time_id'],
            partida_id=partida.id
        )
        db.session.add(novo_evento)

    db.session.commit()

    return jsonify({
        "partida_id": partida.id,
        "gols_mandante": partida.placar_mandante,
        "gols_visitante": partida.placar_visitante,
        "status": partida.status,
        "registrado_por": usuario_id,
        "registrado_em": datetime.utcnow().isoformat() + "Z"
    }), 201

@partidas_bp.route('/partidas/<int:id>/sumula', methods=['GET'])
@jwt_required()
def obter_sumula(id):
    """Retorna a súmula completa de uma partida finalizada (RF16)."""
    partida = Partida.query.get_or_404(id)
    
    # Busca elencos (como não há registro de escalação específica por jogo ainda, 
    # retornamos o elenco inteiro cadastrado nos times)
    mandante_jogadores = partida.time_mandante.jogadores if partida.time_mandante else []
    visitante_jogadores = partida.time_visitante.jogadores if partida.time_visitante else []
    
    # Formata eventos
    eventos = []
    for ev in partida.eventos:
        eventos.append({
            "tipo": ev.tipo,
            "minuto": ev.minuto,
            "jogador": {
                "id": ev.jogador.id,
                "nome": ev.jogador.nome
            } if ev.jogador else None,
            "time": {
                "id": ev.time.id,
                "nome": ev.time.nome
            } if ev.time else None
        })

    return jsonify({
        "partida": {
            "id": partida.id,
            "data": partida.data.isoformat() if partida.data else None,
            "horario": partida.horario,
            "local": partida.local,
            "time_mandante": {
                "id": partida.time_mandante.id,
                "nome": partida.time_mandante.nome,
                "escudo_url": partida.time_mandante.escudo_url
            } if partida.time_mandante else None,
            "time_visitante": {
                "id": partida.time_visitante.id,
                "nome": partida.time_visitante.nome,
                "escudo_url": partida.time_visitante.escudo_url
            } if partida.time_visitante else None,
            "placar_mandante": partida.placar_mandante,
            "placar_visitante": partida.placar_visitante
        },
        "escalacoes": {
            "mandante": [{
                "jogador_id": j.id,
                "nome": j.nome,
                "numero": j.numero,
                "posicao": j.posicao
            } for j in mandante_jogadores],
            "visitante": [{
                "jogador_id": j.id,
                "nome": j.nome,
                "numero": j.numero,
                "posicao": j.posicao
            } for j in visitante_jogadores]
        },
        "eventos": eventos
    }), 200
