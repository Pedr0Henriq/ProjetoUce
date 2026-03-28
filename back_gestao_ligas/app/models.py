from datetime import datetime, timezone
from werkzeug.security import generate_password_hash, check_password_hash
from app import db

class BaseModel(db.Model):
    __abstract__ = True
    
    id = db.Column(db.Integer, primary_key=True)
    criado_em = db.Column(db.DateTime, default=lambda: datetime.now(timezone.utc))
    atualizado_em = db.Column(
        db.DateTime, 
        default=lambda: datetime.now(timezone.utc), 
        onupdate=lambda: datetime.now(timezone.utc)
    )

class Usuario(BaseModel):
    __tablename__ = 'usuarios'
    
    nome = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    senha_hash = db.Column(db.String(255), nullable=False) # Mudamos o nome para deixar claro que é o hash
    perfil = db.Column(db.String(20), nullable=False, default='VIEWER')

    def set_senha(self, senha_texto_plano):
        """Gera o hash da senha e salva no atributo senha_hash"""
        self.senha_hash = generate_password_hash(senha_texto_plano)

    def verificar_senha(self, senha_texto_plano):
        """Compara a senha informada com o hash salvo no banco"""
        return check_password_hash(self.senha_hash, senha_texto_plano)

    def to_dict(self):
        return {
            "id": self.id,
            "nome": self.nome,
            "email": self.email,
            "perfil": self.perfil,
            "criado_em": self.criado_em.isoformat() if self.criado_em else None
        }

class Campeonato(BaseModel):
    __tablename__ = 'campeonatos'

    nome = db.Column(db.String(100), nullable=False)
    modalidade = db.Column(db.String(50), nullable=False)
    tipo = db.Column(db.String(50), nullable=False) # Ex: PONTOS_CORRIDOS, ELIMINATORIA
    num_equipes = db.Column(db.Integer, nullable=False)
    data_inicio = db.Column(db.Date, nullable=False)
    status = db.Column(db.String(50), nullable=False, default='NAO_INICIADO')
    
    # Chaves Estrangeiras
    criado_por = db.Column(db.Integer, db.ForeignKey('usuarios.id'), nullable=False)
    campeao_time_id = db.Column(db.Integer, db.ForeignKey('times.id'), nullable=True)

    # Relacionamentos (facilita muito na hora de buscar os dados encadeados)
    criador = db.relationship('Usuario', foreign_keys=[criado_por], backref='campeonatos_criados')
    times = db.relationship('Time', foreign_keys='Time.campeonato_id', backref='campeonato', lazy=True, cascade="all, delete-orphan")

    def to_dict(self):
        return {
            "id": self.id,
            "nome": self.nome,
            "modalidade": self.modalidade,
            "tipo": self.tipo,
            "num_equipes": self.num_equipes,
            "data_inicio": self.data_inicio.isoformat() if self.data_inicio else None,
            "status": self.status,
            "criado_por": self.criado_por,
            "campeao_time_id": self.campeao_time_id
        }

class Time(BaseModel):
    __tablename__ = 'times'

    nome = db.Column(db.String(100), nullable=False)
    localidade = db.Column(db.String(100), nullable=False)
    escudo_url = db.Column(db.String(255), nullable=True)
    
    # Chave Estrangeira
    campeonato_id = db.Column(db.Integer, db.ForeignKey('campeonatos.id'), nullable=False)

    # Relacionamento com jogadores
    jogadores = db.relationship('Jogador', backref='time', lazy=True, cascade="all, delete-orphan")

    def to_dict(self):
        return {
            "id": self.id,
            "nome": self.nome,
            "localidade": self.localidade,
            "escudo_url": self.escudo_url,
            "campeonato_id": self.campeonato_id
        }

class Jogador(BaseModel):
    __tablename__ = 'jogadores'

    nome = db.Column(db.String(100), nullable=False)
    numero = db.Column(db.Integer, nullable=False)
    posicao = db.Column(db.String(50), nullable=False)
    
    # Chave Estrangeira
    time_id = db.Column(db.Integer, db.ForeignKey('times.id'), nullable=False)

    def to_dict(self):
        return {
            "id": self.id,
            "nome": self.nome,
            "numero": self.numero,
            "posicao": self.posicao,
            "time_id": self.time_id
        }