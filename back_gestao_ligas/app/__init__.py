import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager
from dotenv import load_dotenv

# Carrega as variáveis de ambiente do arquivo .env
load_dotenv()

# Inicializa as extensões vazias (serão vinculadas ao app depois)
db = SQLAlchemy()
jwt = JWTManager()

def create_app():
    app = Flask(__name__)

    # Puxa as configurações do .env (com valores padrão de segurança para dev)
    app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY', 'dev')
    app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('SQLALCHEMY_DATABASE_URI', 'sqlite:///gestao_ligas.db')
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['JWT_SECRET_KEY'] = os.environ.get('JWT_SECRET_KEY', 'jwt_dev')

    # Vincula o banco de dados e o JWT ao nosso app
    db.init_app(app)
    jwt.init_app(app)

    # Importação e registro dos Blueprints (rotas) - Deixei comentado por enquanto!
    # Lembre-se que a documentação pede a base URL com /v1 [cite: 2]
    from app.routes.auth import auth_bp
    from app.routes.campeonatos import campeonatos_bp
    app.register_blueprint(auth_bp, url_prefix='/v1/auth')
    app.register_blueprint(campeonatos_bp, url_prefix='/v1/campeonatos')

    # Garante que o banco de dados e as tabelas sejam criados na inicialização
    with app.app_context():
        db.create_all()

    return app