# Gestão de Ligas — Backend (API REST)

API REST desenvolvida com **Flask** para suportar o aplicativo móvel Flutter de gerenciamento de campeonatos esportivos.

---

## Requisitos

| Ferramenta | Versão mínima |
|------------|--------------|
| Python | 3.10+ |
| pip | 23+ |
| PostgreSQL | 14+ (ou SQLite para dev) |

---

## Instalação

```bash
# 1. Clone o repositório e entre na pasta do backend
cd back_gestao_ligas

# 2. Crie e ative o ambiente virtual
python -m venv .venv
# Windows
.venv\Scripts\activate
# Linux / macOS
source .venv/bin/activate

# 3. Instale as dependências com versões fixadas
pip install -r requirements.txt

# 4. Configure as variáveis de ambiente
cp .env.example .env
# Edite .env com suas credenciais reais
```

---

## Variáveis de Ambiente

Copie `.env.example` para `.env` e preencha os campos:

| Variável | Descrição |
|----------|-----------|
| `SECRET_KEY` | Chave secreta da aplicação Flask |
| `JWT_SECRET_KEY` | Chave secreta para assinatura dos tokens JWT |
| `SQLALCHEMY_DATABASE_URI` | URI de conexão com o banco de dados |
| `CORS_ORIGINS` | Origens permitidas no CORS (`*` em dev local) |
| `BOOTSTRAP_ADMIN_ENABLED` | Ativa criação/promoção automática do primeiro ADMIN (`true/false`) |
| `BOOTSTRAP_ADMIN_NAME` | Nome do administrador inicial |
| `BOOTSTRAP_ADMIN_EMAIL` | E-mail do administrador inicial |
| `BOOTSTRAP_ADMIN_PASSWORD` | Senha inicial do administrador |

---

## Execução

```bash
# Desenvolvimento (hot-reload, modo debug)
python run.py

# Produção (exemplo com Gunicorn)
gunicorn -w 4 -b 0.0.0.0:5005 "app:create_app()"
```

O servidor sobe na porta **5005** por padrão e aceita conexões de qualquer interface (`0.0.0.0`), permitindo acesso pelo app físico na mesma rede Wi-Fi.

---

## Health Check

```
GET /v1/health
```

Retorna `{"status": "ok", "versao": "1.1.0"}` — use para verificar conectividade antes de autenticar.

---

## Endpoints Principais

### Autenticação — `/v1/auth`

| Método | Rota | Descrição | Auth |
|--------|------|-----------|------|
| POST | `/login` | Login com e-mail e senha; retorna JWT | — |
| POST | `/register` | Cadastrar novo usuário (sempre perfil VIEWER) | — |
| GET | `/perfil` | Dados do usuário autenticado | JWT |
| PUT | `/perfil` | Atualizar nome, e-mail ou senha | JWT |
| POST | `/recuperar-senha` | Solicitar link de redefinição | — |
| POST | `/reset-password` | Redefinir senha via token | — |
| POST | `/logout` | Encerrar sessão (invalida no cliente) | JWT |
| POST | `/refresh` | Renovar token JWT | JWT |

Observação: contas desativadas não conseguem autenticar e tokens antigos são invalidados.

### Usuários (Admin) — `/v1`

| Método | Rota | Descrição | Auth |
|--------|------|-----------|------|
| GET | `/usuarios` | Listar usuários do sistema | JWT (ADMIN) |
| POST | `/usuarios/:id/promover` | Promover usuário para ADMIN | JWT (ADMIN) |
| POST | `/usuarios/:id/desativar` | Desativar usuário (soft-disable) | JWT (ADMIN) |

### Campeonatos — `/v1/campeonatos`

| Método | Rota | Descrição | Auth |
|--------|------|-----------|------|
| GET | `/` | Listar campeonatos (filtro `?busca=`) | JWT |
| POST | `/` | Criar campeonato | JWT (ADMIN) |
| GET | `/:id` | Detalhes de um campeonato | JWT |
| PUT | `/:id` | Editar campeonato | JWT (ADMIN) |
| DELETE | `/:id` | Excluir campeonato | JWT (ADMIN) |
| POST | `/:id/encerrar` | Encerrar campeonato (requer `campeao_time_id`) | JWT (ADMIN) |

### Times — `/v1`

| Método | Rota | Descrição | Auth |
|--------|------|-----------|------|
| GET | `/campeonatos/:id/times` | Listar times de um campeonato | JWT |
| POST | `/campeonatos/:id/times` | Criar time | JWT (ADMIN) |
| GET | `/times/:id` | Detalhes de um time | JWT |
| PUT | `/times/:id` | Editar time | JWT (ADMIN) |
| DELETE | `/times/:id` | Excluir time e jogadores | JWT (ADMIN) |

### Jogadores — `/v1`

| Método | Rota | Descrição | Auth |
|--------|------|-----------|------|
| GET | `/times/:timeId/jogadores` | Listar jogadores de um time | JWT |
| POST | `/times/:timeId/jogadores` | Adicionar jogador | JWT (ADMIN) |
| PUT | `/jogadores/:id` | Editar jogador | JWT (ADMIN) |
| DELETE | `/jogadores/:id` | Remover jogador | JWT (ADMIN) |

### Partidas — `/v1`

| Método | Rota | Descrição | Auth |
|--------|------|-----------|------|
| POST | `/campeonatos/:id/partidas` | Criar partida manual | JWT (ADMIN) |
| GET | `/campeonatos/:id/partidas` | Listar partidas (por rodada) | JWT |
| POST | `/campeonatos/:id/gerar-calendario` | Gerar calendário Round-Robin | JWT (ADMIN) |
| GET | `/partidas/:id` | Detalhes da partida | JWT |
| PUT | `/partidas/:id` | Editar partida | JWT (ADMIN) |
| DELETE | `/partidas/:id` | Remover partida | JWT (ADMIN) |
| POST | `/partidas/:id/resultado` | Registrar placar e eventos | JWT (ADMIN) |
| GET | `/partidas/:id/sumula` | Súmula da partida | JWT |
| GET | `/partidas/:id/eventos` | Lista de eventos (compatibilidade) | JWT |

### Estatísticas — `/v1`

| Método | Rota | Descrição | Auth |
|--------|------|-----------|------|
| GET | `/campeonatos/:id/classificacao` | Tabela de classificação | JWT |
| GET | `/campeonatos/:id/artilharia` | Artilheiros e assistentes | JWT |

### Administradores (RF17) — `/v1`

| Método | Rota | Descrição | Auth |
|--------|------|-----------|------|
| GET | `/campeonatos/:id/administradores` | Listar co-admins | JWT (ADMIN) |
| POST | `/campeonatos/:id/administradores` | Vincular co-admin por e-mail | JWT (ADMIN) |
| DELETE | `/campeonatos/:id/administradores/:uid` | Desvincular co-admin | JWT (ADMIN) |

Observação: o acesso exige ser administrador global ou co-administrador do campeonato.

---

## Estrutura do Projeto

```
back_gestao_ligas/
├── app/
│   ├── __init__.py          # Factory da aplicação Flask + health check
│   ├── models.py            # Modelos SQLAlchemy (Usuario, Campeonato, Time, ...)
│   └── routes/
│       ├── auth.py          # Autenticação + perfil + aliases Flutter
│       ├── campeonatos.py   # CRUD de campeonatos
│       ├── times.py         # CRUD de times
│       ├── jogadores.py     # CRUD de jogadores
│       ├── partidas.py      # Calendário, resultados, súmula
│       ├── estatisticas.py  # Classificação + artilharia
│       ├── administradores.py  # RF17 — co-administradores
│       ├── usuarios.py      # Gestão administrativa de usuários
│       └── busca.py         # Busca global
├── run.py                   # Entry-point para desenvolvimento
├── requirements.txt         # Dependências com versões fixadas
├── .env.example             # Template de variáveis de ambiente
└── CHANGELOG.md             # Histórico de versões
```

---

## Autenticação

A API usa **JWT (Bearer Token)**. Inclua o header em todas as rotas protegidas:

```
Authorization: Bearer <access_token>
```

Tokens expiram em **1 hora**. Use `POST /v1/auth/refresh` para renovar sem reautenticar.

No cadastro público (`POST /v1/auth/register`), o perfil é sempre salvo como `VIEWER`.
Tentativas de registrar conta com perfil `ADMIN` são rejeitadas com erro `400`.

## Bootstrap do Primeiro Administrador

Na inicialização da API, se `BOOTSTRAP_ADMIN_ENABLED=true` e ainda não existir
nenhum usuário com perfil `ADMIN`, o sistema cria (ou promove por e-mail)
uma conta administrativa usando as variáveis `BOOTSTRAP_ADMIN_*`.

Recomendação: após o primeiro login, altere imediatamente a senha inicial.

---

## Notas de Segurança

- Nunca commite o arquivo `.env` — ele está no `.gitignore`.
- Em produção, substitua os valores padrão de `SECRET_KEY` e `JWT_SECRET_KEY`.
- O endpoint `/logout` é semântico: a invalidação real do token ocorre no cliente.
