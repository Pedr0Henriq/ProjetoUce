import site

from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity
from datetime import datetime
from app.models import Campeonato, Usuario
from app import db

campeonatos_bp = Blueprint('campeonatos', __name__)

# --- Função Auxiliar ---
def is_admin(usuario_id):
    """Verifica se o usuário logado tem perfil de ADMIN."""
    usuario = Usuario.query.get(usuario_id)
    return usuario and usuario.perfil == 'ADMIN'

# --- Rotas ---

@campeonatos_bp.route('', methods=['GET'])
@jwt_required()
def listar_campeonatos():
    """RF03, RF14, RF15 - Lista campeonatos com filtros opcionais."""
    # Permissão: autenticado (ADMIN ou VIEWER) - O @jwt_required() já garante isso[cite: 116].
    
    # Captura os query params (ex: /campeonatos?status=ativo&busca=liga) [cite: 117-119]
    status_param = request.args.get('status')
    busca_param = request.args.get('busca')
    
    query = Campeonato.query

    if status_param:
        # Se vier 'ativo', buscamos 'EM_ANDAMENTO' ou 'NAO_INICIADO', senao buscamos o exato (ex: 'ENCERRADO') [cite: 118]
        if status_param.lower() == 'ativo':
            query = query.filter(Campeonato.status != 'ENCERRADO')
        else:
            query = query.filter(Campeonato.status == status_param.upper())
            
    if busca_param:
        # Busca parcial ignorando maiúsculas/minúsculas (ilike no SQLite/Postgres) [cite: 119]
        query = query.filter(Campeonato.nome.ilike(f'%{busca_param}%'))

    campeonatos = query.all()
    return jsonify([c.to_dict() for c in campeonatos]), 200


@campeonatos_bp.route('', methods=['POST'])
@jwt_required()
def criar_campeonato():
    """RF03 - Cria um novo campeonato."""
    usuario_id = get_jwt_identity()
    
    # Permissão: ADMIN[cite: 135].
    if not is_admin(usuario_id):
        return jsonify({"erro": "Acesso negado. Apenas administradores podem criar campeonatos."}), 403

    dados = request.get_json()
    
    # Validação básica
    campos_obrigatorios = ['nome', 'modalidade', 'tipo', 'num_equipes', 'data_inicio']
    if not dados or not all(campo in dados for campo in campos_obrigatorios):
        return jsonify({"erro": "Dados incompletos"}), 400

    try:
        # Converte a string 'YYYY-MM-DD' para um objeto Date do Python [cite: 143]
        data_inicio_obj = datetime.strptime(dados['data_inicio'], '%Y-%m-%d').date()
    except ValueError:
        return jsonify({"erro": "Formato de data inválido. Use YYYY-MM-DD"}), 400

    novo_campeonato = Campeonato(
        nome=dados['nome'],
        modalidade=dados['modalidade'],
        tipo=dados['tipo'],
        num_equipes=dados['num_equipes'],
        data_inicio=data_inicio_obj,
        status='NAO_INICIADO', # Status padrão [cite: 155]
        criado_por=usuario_id  # Pega o ID de quem está logado [cite: 156]
    )

    db.session.add(novo_campeonato)
    db.session.commit()

    return jsonify(novo_campeonato.to_dict()), 201


@campeonatos_bp.route('/<int:id>', methods=['GET'])
@jwt_required()
def obter_campeonato(id):
    """Retorna os detalhes de um campeonato específico."""
    # Permissão: autenticado[cite: 162].
    campeonato = Campeonato.query.get_or_404(id)
    return jsonify(campeonato.to_dict()), 200


@campeonatos_bp.route('/<int:id>', methods=['PUT'])
@jwt_required()
def atualizar_campeonato(id):
    """Atualiza dados permitidos de um campeonato."""
    usuario_id = get_jwt_identity()
    
    # Permissão: ADMIN[cite: 173].
    if not is_admin(usuario_id):
        return jsonify({"erro": "Acesso negado."}), 403

    campeonato = Campeonato.query.get_or_404(id)
    dados = request.get_json()

    # Atualiza apenas os campos permitidos pelo body (nome e data_inicio) [cite: 174-176]
    if 'nome' in dados:
        campeonato.nome = dados['nome']
    if 'data_inicio' in dados:
        try:
            campeonato.data_inicio = datetime.strptime(dados['data_inicio'], '%Y-%m-%d').date()
        except ValueError:
            return jsonify({"erro": "Formato de data inválido. Use YYYY-MM-DD"}), 400

    db.session.commit()
    return jsonify(campeonato.to_dict()), 200 # Retorna objeto atualizado [cite: 178]


@campeonatos_bp.route('/<int:id>', methods=['DELETE'])
@jwt_required()
def deletar_campeonato(id):
    """Exclui um campeonato, desde que não esteja encerrado."""
    usuario_id = get_jwt_identity()
    
    # Permissão: ADMIN[cite: 180].
    if not is_admin(usuario_id):
        return jsonify({"erro": "Acesso negado."}), 403

    campeonato = Campeonato.query.get_or_404(id)

    # Regra: não pode excluir se status = ENCERRADO[cite: 181].
    if campeonato.status == 'ENCERRADO':
        return jsonify({"erro": "Não é possível excluir um campeonato já encerrado."}), 400

    db.session.delete(campeonato)
    db.session.commit()

    return '', 204 # Retorna 204 sem corpo [cite: 182]


@campeonatos_bp.route('/<int:id>/encerrar', methods=['POST'])
@jwt_required()
def encerrar_campeonato(id):
    """RF14 - Encerra o campeonato e define o time campeão."""
    usuario_id = get_jwt_identity()
    
    # Permissão: ADMIN[cite: 186].
    if not is_admin(usuario_id):
        return jsonify({"erro": "Acesso negado."}), 403

    campeonato = Campeonato.query.get_or_404(id)
    dados = request.get_json()

    if not dados or 'campeao_time_id' not in dados:
        return jsonify({"erro": "O ID do time campeão é obrigatório."}), 400

    campeonato.status = 'ENCERRADO' [site: 195]
    campeonato.campeao_time_id = dados['campeao_time_id'] [site: 196]
    
    db.session.commit()

    return jsonify(campeonato.to_dict()), 200 [site: 190]