# Changelog — Gestão de Ligas (Backend)

Todas as mudanças notáveis da API REST são documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/).

---

## [1.1.0] — 2026-04-07

### Adicionado
- **Health check** `GET /v1/health`: retorna `{"status":"ok","versao":"1.1.0"}` para
  verificação de conectividade pelo app móvel antes de autenticar.
- **Aliases Flutter** em `auth.py`:
  - `GET /v1/auth/perfil` → delega para `GET /v1/auth/me`
  - `PUT /v1/auth/perfil` → delega para `PUT /v1/auth/me`
  - `POST /v1/auth/recuperar-senha` → delega para `POST /v1/auth/forgot-password`
  - `POST /v1/auth/logout` → encerra sessão (JWT stateless; invalidação no cliente)
- **RF17 — `DELETE /v1/campeonatos/:id/administradores/:uid`**: novo endpoint para
  desvincular co-administrador de um campeonato; impede auto-remoção.
- **`.env.example`**: template documentado com `SECRET_KEY`, `JWT_SECRET_KEY` e
  `SQLALCHEMY_DATABASE_URI` (exemplos para PostgreSQL e SQLite).
- **`README.md`**: documentação completa — requisitos, instalação, variáveis de
  ambiente, execução, tabela de endpoints e notas de segurança.

### Corrigido
- **RF17 — `POST /v1/campeonatos/:id/administradores`**: endpoint agora aceita
  `{"email":"..."}` em vez de `{"usuario_id":...}`, alinhando com o contrato do
  app Flutter. Qualquer usuário cadastrado pode ser adicionado como co-admin de
  campeonato (não é mais exigido perfil ADMIN global).
- **RF17 — `GET /v1/campeonatos/:id/administradores`**: chave da resposta corrigida
  de `"usuario_id"` para `"id"`, alinhando com o modelo `Usuario` esperado pelo Flutter.
- **Validação de e-mail** em `register()` e `update_me()`: formato verificado via
  regex `^[^@\s]+@[^@\s]+\.[^@\s]+$` antes de consultar o banco.

### Modificado
- **`requirements.txt`**: versões de todas as dependências agora fixadas para builds
  reproduzíveis (`Flask==3.0.3`, `Flask-SQLAlchemy==3.1.1`, `Flask-JWT-Extended==4.6.0`,
  `python-dotenv==1.0.1`, `Flask-Cors==4.0.1`, `Werkzeug==3.0.3`).
- **`administradores.py`**: função auxiliar renomeada para `_e_admin_global` (prefixo
  `_` indicando uso interno); adicionadas docstrings completas em todos os endpoints.

---

## [1.0.0] — 2026-04-07

### Adicionado
- **RF01 — Autenticação**: `POST /v1/auth/login` com JWT (1 h de expiração) e
  `POST /v1/auth/refresh` para renovação de token.
- **RF01 — Cadastro**: `POST /v1/auth/register` com perfis `ADMIN` e `VIEWER`.
- **RF01 — Recuperar senha**: `POST /v1/auth/forgot-password` + `POST /v1/auth/reset-password`
  com token JWT temporário (15 min).
- **RF01 — Perfil**: `GET /v1/auth/me` e `PUT /v1/auth/me` para consulta e edição
  de nome, e-mail e senha.
- **RF03 — Campeonatos**: CRUD completo em `/v1/campeonatos` com filtro de busca
  (`?busca=`), encerramento (`POST /:id/encerrar`) e exclusão em cascata.
- **RF04 — Resultados**: `PUT /v1/partidas/:id/resultado` registra placar e eventos
  (gols, assistências, cartões) com validações.
- **RF05 — Times**: CRUD em `/v1/campeonatos/:id/times` e `/v1/times/:id`.
- **RF06 — Jogadores**: CRUD em `/v1/times/:id/jogadores` e `/v1/jogadores/:id`.
- **RF07 — Calendário**: `POST /v1/campeonatos/:id/gerar-calendario` com algoritmo
  Round-Robin para geração automática de confrontos.
- **RF08 — Partidas**: listagem por rodada em `GET /v1/campeonatos/:id/partidas`.
- **RF09 — Classificação**: `GET /v1/campeonatos/:id/classificacao` com
  J/V/E/D/GP/GC/SG/PTS calculados dinamicamente.
- **RF10 — Artilharia**: `GET /v1/campeonatos/:id/artilharia` com ranking de
  artilheiros e assistentes.
- **RF16 — Súmula**: `GET /v1/partidas/:id` retorna linha do tempo de eventos e
  escalações.
- **RF17 — Administradores**: `GET` e `POST` em `/v1/campeonatos/:id/administradores`
  para gerenciar co-admins de um campeonato.
- **Busca global**: `GET /v1/busca?q=` pesquisa campeonatos, times e jogadores
  simultaneamente.
- **Flask-CORS** habilitado globalmente para permitir requisições do app Flutter.
- **Modelos SQLAlchemy**: `Usuario`, `Campeonato`, `Time`, `Jogador`, `Partida`,
  `EventoPartida` e tabela M2M `campeonato_administradores`.
- **Hash de senha** com Werkzeug (`generate_password_hash` / `check_password_hash`).
