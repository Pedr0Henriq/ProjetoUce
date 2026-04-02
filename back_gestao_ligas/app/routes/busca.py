from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required
from app.models import Campeonato, Time, Jogador

busca_bp = Blueprint('busca', __name__)

@busca_bp.route('/busca', methods=['GET'])
@jwt_required()
def realizar_busca():
    """Busca por nome em campeonatos, times e/ou jogadores simultaneamente (RF15)."""
    q = request.args.get('q')
    if not q:
        return jsonify({"erro": "O parâmetro de busca 'q' é obrigatório."}), 400
        
    tipo = request.args.get('tipo', 'todos').lower()
    
    termo = f"%{q}%"
    resultados = {
        "campeonatos": [],
        "times": [],
        "jogadores": []
    }
    
    if tipo in ['todos', 'campeonato']:
        campeonatos = Campeonato.query.filter(Campeonato.nome.ilike(termo)).all()
        resultados['campeonatos'] = [c.to_dict() for c in campeonatos]
        
    if tipo in ['todos', 'time']:
        times = Time.query.filter(Time.nome.ilike(termo)).all()
        for t in times:
            resultados['times'].append({
                "id": t.id,
                "nome": t.nome,
                "campeonato_id": t.campeonato_id
            })
            
    if tipo in ['todos', 'jogador']:
        jogadores = Jogador.query.filter(Jogador.nome.ilike(termo)).all()
        resultados['jogadores'] = [j.to_dict() for j in jogadores]
        
    return jsonify(resultados), 200
