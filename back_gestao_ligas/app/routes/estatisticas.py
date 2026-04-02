from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required
from app.models import Campeonato, Time, Partida, EventoPartida, Jogador
from app import db

estatisticas_bp = Blueprint('estatisticas', __name__)

def calcular_stats_base(campeonato_id):
    """Calcula estatísticas de todos os times de um campeonato baseado nas partidas finalizadas."""
    times = Time.query.filter_by(campeonato_id=campeonato_id).all()
    partidas = Partida.query.filter_by(campeonato_id=campeonato_id, status='FINALIZADA').all()
    
    stats = {}
    for t in times:
        stats[t.id] = {
            "time": {"id": t.id, "nome": t.nome, "escudo_url": t.escudo_url},
            "jogos": 0, "vitorias": 0, "empates": 0, "derrotas": 0,
            "gols_pro": 0, "gols_contra": 0, "saldo": 0, "pontos": 0
        }
        
    for p in partidas:
        m_id = p.time_mandante_id
        v_id = p.time_visitante_id
        g_m = p.placar_mandante or 0
        g_v = p.placar_visitante or 0
        
        if m_id in stats:
            stats[m_id]["jogos"] += 1
            stats[m_id]["gols_pro"] += g_m
            stats[m_id]["gols_contra"] += g_v
            stats[m_id]["saldo"] += (g_m - g_v)
            if g_m > g_v:
                stats[m_id]["vitorias"] += 1
                stats[m_id]["pontos"] += 3
            elif g_m == g_v:
                stats[m_id]["empates"] += 1
                stats[m_id]["pontos"] += 1
            else:
                stats[m_id]["derrotas"] += 1
                
        if v_id in stats:
            stats[v_id]["jogos"] += 1
            stats[v_id]["gols_pro"] += g_v
            stats[v_id]["gols_contra"] += g_m
            stats[v_id]["saldo"] += (g_v - g_m)
            if g_v > g_m:
                stats[v_id]["vitorias"] += 1
                stats[v_id]["pontos"] += 3
            elif g_v == g_m:
                stats[v_id]["empates"] += 1
                stats[v_id]["pontos"] += 1
            else:
                stats[v_id]["derrotas"] += 1
                
    return stats

@estatisticas_bp.route('/campeonatos/<int:campeonato_id>/estatisticas/times', methods=['GET'])
@jwt_required()
def obter_estatisticas_times(campeonato_id):
    """Retorna estatísticas coletivas de todos os times (RF10)."""
    Campeonato.query.get_or_404(campeonato_id)
    stats_dict = calcular_stats_base(campeonato_id)
    return jsonify(list(stats_dict.values())), 200

@estatisticas_bp.route('/campeonatos/<int:campeonato_id>/classificacao', methods=['GET'])
@jwt_required()
def obter_classificacao(campeonato_id):
    """Retorna a tabela de classificação baseada nas estatísticas, ordenada conforme RF09."""
    Campeonato.query.get_or_404(campeonato_id)
    stats_dict = calcular_stats_base(campeonato_id)
    
    lista = list(stats_dict.values())
    
    # Critérios de desempate: Pontos > Vitórias > Saldo > Gols Pro
    lista_ordenada = sorted(
        lista, 
        key=lambda k: (k['pontos'], k['vitorias'], k['saldo'], k['gols_pro']), 
        reverse=True
    )
    
    # Injetando o campo 'posicao' após a ordenação
    for index, obj in enumerate(lista_ordenada):
        obj['posicao'] = index + 1
        
    return jsonify(lista_ordenada), 200

@estatisticas_bp.route('/campeonatos/<int:campeonato_id>/artilharia', methods=['GET'])
@jwt_required()
def obter_artilharia(campeonato_id):
    """Retorna o ranking de artilheiros e líderes baseados nos eventos gerados (RF10)."""
    Campeonato.query.get_or_404(campeonato_id)
    
    eventos = db.session.query(EventoPartida, Jogador, Time).join(Jogador, EventoPartida.jogador_id == Jogador.id)\
               .join(Time, Jogador.time_id == Time.id)\
               .join(Partida, EventoPartida.partida_id == Partida.id)\
               .filter(Partida.campeonato_id == campeonato_id, Partida.status == 'FINALIZADA').all()
               
    jogadores_stats = {}
    
    for ev, jog, time in eventos:
        j_id = jog.id
        if j_id not in jogadores_stats:
            jogadores_stats[j_id] = {
                "jogador": {
                    "id": j_id,
                    "nome": jog.nome,
                    "time": {
                        "id": time.id,
                        "nome": time.nome
                    }
                },
                "gols": 0,
                "assistencias": 0,
                "cartoes_amarelos": 0,
                "cartoes_vermelhos": 0
            }
            
        t = ev.tipo.upper()
        if t == 'GOL':
            jogadores_stats[j_id]["gols"] += 1
        elif t == 'ASSISTENCIA':
            jogadores_stats[j_id]["assistencias"] += 1
        elif t == 'CARTAO_AMARELO':
            jogadores_stats[j_id]["cartoes_amarelos"] += 1
        elif t == 'CARTAO_VERMELHO':
            jogadores_stats[j_id]["cartoes_vermelhos"] += 1
            
    lista = list(jogadores_stats.values())
    
    # Ordenar por: Mais Gols, logo mais Assistencias
    lista_ordenada = sorted(
        lista, 
        key=lambda k: (k['gols'], k['assistencias']), 
        reverse=True
    )
    
    return jsonify(lista_ordenada), 200

@estatisticas_bp.route('/times/<int:time_id>/historico-partidas', methods=['GET'])
@jwt_required()
def historico_time(time_id):
    """Retorna o histórico completo de partidas de um time com plcares focados no mandante."""
    Time.query.get_or_404(time_id)
    
    query = Partida.query.filter(
        (Partida.time_mandante_id == time_id) | (Partida.time_visitante_id == time_id)
    )
    
    camp_id = request.args.get('campeonato_id')
    if camp_id:
        query = query.filter(Partida.campeonato_id == int(camp_id))
        
    # Ordenar pelas partidas finalizadas mais recentes e as marcadas usando a data
    # Tratamento para ordenação simples usando .data 
    # Usaremos order_by do sqlalchemy para as datas
    partidas = query.order_by(Partida.data.desc().nullslast()).all()
    
    historico = []
    
    for p in partidas:
        is_mandante = p.time_mandante_id == time_id
        adversario = p.time_visitante if is_mandante else p.time_mandante
        
        historico.append({
            "id": p.id,
            "campeonato_id": p.campeonato_id,
            "data": p.data.isoformat() if p.data else None,
            "rodada": p.rodada,
            "adversario": {
                "id": adversario.id if adversario else None,
                "nome": adversario.nome if adversario else "BYE" # Trata time fantasma se houver
            },
            "mandante": is_mandante,
            "placar_mandante": p.placar_mandante,
            "placar_visitante": p.placar_visitante,
            "status": p.status
        })
        
    return jsonify(historico), 200
