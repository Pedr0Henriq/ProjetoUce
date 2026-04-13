import os
from flask import Flask, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager
from dotenv import load_dotenv
from flask_cors import CORS

load_dotenv()

db = SQLAlchemy()
jwt = JWTManager()


def _env_bool(name, default=False):
    """Converte variável de ambiente em booleano."""
    raw = os.environ.get(name)
    if raw is None:
        return default
    return raw.strip().lower() in {'1', 'true', 'yes', 'y', 'on'}

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

        # Bootstrap idempotente do primeiro administrador global.
        # Se já existir qualquer ADMIN, nada é feito.
        if _env_bool('BOOTSTRAP_ADMIN_ENABLED', default=True):
            from app.models import Usuario

            admin_existente = Usuario.query.filter_by(perfil='ADMIN').first()
            if not admin_existente:
                admin_nome = os.environ.get('BOOTSTRAP_ADMIN_NAME', 'Administrador Inicial').strip() or 'Administrador Inicial'
                admin_email = os.environ.get('BOOTSTRAP_ADMIN_EMAIL', 'admin@ligas.local').strip().lower() or 'admin@ligas.local'
                admin_senha = os.environ.get('BOOTSTRAP_ADMIN_PASSWORD', 'admin123')

                usuario_mesmo_email = Usuario.query.filter_by(email=admin_email).first()
                if usuario_mesmo_email:
                    usuario_mesmo_email.perfil = 'ADMIN'
                    if not usuario_mesmo_email.senha_hash:
                        usuario_mesmo_email.set_senha(admin_senha)
                    db.session.commit()
                    app.logger.warning('Bootstrap ADMIN: usuário existente promovido para ADMIN (%s). Troque a senha após o primeiro login.', admin_email)
                else:
                    novo_admin = Usuario(
                        nome=admin_nome,
                        email=admin_email,
                        perfil='ADMIN',
                    )
                    novo_admin.set_senha(admin_senha)
                    db.session.add(novo_admin)
                    db.session.commit()
                    app.logger.warning('Bootstrap ADMIN: conta inicial criada (%s). Troque a senha após o primeiro login.', admin_email)

    return app