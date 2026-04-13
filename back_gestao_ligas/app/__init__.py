import os
from flask import Flask, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager
from dotenv import load_dotenv
from flask_cors import CORS

load_dotenv()

db = SQLAlchemy()
jwt = JWTManager()

def create_app():
    app = Flask(__name__)
    cors_origins = os.environ.get('CORS_ORIGINS', '*')
    if cors_origins.strip() == '*':
        CORS(app)
    else:
        origins = [o.strip() for o in cors_origins.split(',') if o.strip()]
        CORS(app, origins=origins, supports_credentials=True)

    app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY', 'dev')
    app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('SQLALCHEMY_DATABASE_URI', 'sqlite:///gestao_ligas.db')
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['JWT_SECRET_KEY'] = os.environ.get('JWT_SECRET_KEY', 'jwt_dev')

    db.init_app(app)
    jwt.init_app(app)

    from app.routes.auth import auth_bp
    from app.routes.campeonatos import campeonatos_bp
    from app.routes.times import times_bp
    from app.routes.jogadores import jogadores_bp
    from app.routes.partidas import partidas_bp
    from app.routes.estatisticas import estatisticas_bp
    from app.routes.busca import busca_bp
    from app.routes.administradores import administradores_bp
    
    app.register_blueprint(auth_bp, url_prefix='/v1/auth')
    app.register_blueprint(campeonatos_bp, url_prefix='/v1/campeonatos')
    app.register_blueprint(times_bp, url_prefix='/v1')
    app.register_blueprint(jogadores_bp, url_prefix='/v1')
    app.register_blueprint(partidas_bp, url_prefix='/v1')
    app.register_blueprint(estatisticas_bp, url_prefix='/v1')
    app.register_blueprint(busca_bp, url_prefix='/v1')
    app.register_blueprint(administradores_bp, url_prefix='/v1')

    # ── Health check ─────────────────────────────────────────────────────────
    @app.route('/v1/health')
    def health():
        """Verifica se a API está no ar.

        Usado pelo app móvel na inicialização para confirmar conectividade antes
        de tentar autenticar, evitando mensagens de erro genéricas ao usuário.

        Returns:
            200: ``{"status": "ok", "versao": "1.1.0"}``
        """
        return jsonify({"status": "ok", "versao": "1.1.0"}), 200

    with app.app_context():
        db.create_all()

    return app