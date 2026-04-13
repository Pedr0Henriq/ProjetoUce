# Gestao de Ligas - Documentacao Oficial

Sistema mobile/web para organizacao de campeonatos esportivos comunitarios com back-end em Python e front-end em Flutter.

## 1. Visao Geral do Sistema

O sistema cobre os fluxos principais de organizacao de ligas esportivas comunitarias:
- Autenticacao e perfis de usuarios.
- Gestao de campeonatos, times, jogadores e partidas.
- Registro de resultados e eventos em sumulas.
- Estatisticas em tempo real: classificacao, artilharia e saldo de gols.
- Encerramento de campeonato com definicao oficial de campeao.
- Permissoes de co-administracao por campeonato.

## 2. Estrutura do Repositorio

```text
ProjetoUce/
  back_gestao_ligas/      API Flask
  front_gestao_ligas/     App Flutter
  requisitos_extraido.txt Requisitos do sistema
```

## 3. Pre-Requisitos e Ambiente

### Backend
- Python 3.10+
- pip 23+

### Frontend
- Flutter SDK 3.24+
- Dart SDK compativel
- Android Studio (se for gerar APK/AAB)

### Ambiente
- Windows 10/11, macOS ou Linux
- Porta 5005 livre (backend)

## 4. Implantacao Local (Academica)

### 4.1 Backend (Flask)

No terminal, entre na pasta do backend:
```bash
cd back_gestao_ligas
```

Crie e ative o ambiente virtual:
```bash
python -m venv .venv

# Windows (cmd):
.venv\Scripts\activate.bat

# Linux/macOS:
source .venv/bin/activate
```

Instale dependencias e configure o ambiente:
```bash
pip install -r requirements.txt
cp .env.example .env
```

Execute a API:
```bash
python run.py
```

Health check:
```bash
curl http://localhost:5005/v1/health
```
*(Base URL: `http://127.0.0.1:5005/v1`. Autenticacao via JWT no Header).*

### 4.2 Frontend (Flutter)

Em outro terminal, entre na pasta do app:
```bash
cd front_gestao_ligas
flutter pub get
```

Executando o App:
O aplicativo detecta automaticamente o seu emulador em desenvolvimento local (iOS/macOS usam 127.0.0.1 e Android usa 10.0.2.2 nativamente na porta 5005).

```bash
# Android Emulator ou iOS Simulator
flutter run

# Web
flutter run -d chrome

# Dispositivo Fisico (Substitua pelo seu IP de Rede Local)
flutter run --dart-define=API_HOST=192.168.1.50 --dart-define=API_PORT=5005
```

## 5. Seguranca e Permissoes (RBAC)

- **VIEWER:** Acesso apenas leitura a recursos publicos (Classificacoes, Visualizar Times, Sumulas).
- **ADMIN Global:** Administrador geral do sistema (necessario para criar novas ligas).
- **Dono da Liga (is_campeonato_admin):** A API possui protecao granular. Um ADMIN so pode editar, excluir ou adicionar times/partidas em um campeonato se ele for o Criador do torneio, ou tiver sido adicionado como um Co-Administrador.

## 6. Documentacao da API (Endpoints Principais)

Todos requintam Content-Type `application/json` e Header `Authorization: Bearer <token>`.

### 6.1. Autenticacao e Usuarios (/auth)
- POST /auth/register - Cria uma nova conta.
- POST /auth/login - Autentica o usuario e retorna o access_token.
- POST /auth/refresh - Renova um token expirado.
- POST /auth/forgot-password - Solicita recuperacao de senha.
- POST /auth/reset-password - Redefine a senha com o token.
- GET /auth/me - Retorna os dados do usuario logado.
- PUT /auth/me - Atualiza dados cadastrais/senha.

### 6.2. Campeonatos (/campeonatos)
- POST /campeonatos - [ADMIN] Inicializa um novo torneio matriz.
- GET /campeonatos - Lista torneios (Filtros: ?status=ativo ou ?busca=nome).
- GET /campeonatos/{id} - Detalhes estruturais do campeonato.
- PUT /campeonatos/{id} - [DONO] Atualiza dados descritivos (nome, data).
- DELETE /campeonatos/{id} - [DONO] Exclui torneio profundamente (vetado se status = ENCERRADO).
- POST /campeonatos/{id}/encerrar - [DONO] Fecha a Liga de forma irreversivel e define o Time Campeao.

### 6.3. Times (/times)
- POST /campeonatos/{id}/times - [DONO] Inscreve uma agremiacao na liga.
- GET /campeonatos/{id}/times - Retorna as fichas de todos os times matriculados.
- GET /times/{id} - Exibe dados do time e estatisticas embutidas.
- PUT /times/{id} - [DONO] Atualiza informacoes de brasao e nome.
- DELETE /times/{id} - [DONO] Remove o time da liga.

### 6.4. Jogadores (/jogadores)
- POST /times/{id}/jogadores - [DONO] Contrata jogador pro time definindo numeracao e posicionamento.
- GET /times/{id}/jogadores - Requisita o elenco.
- PUT /jogadores/{id} - [DONO] Altera numeracao/posicao.
- DELETE /jogadores/{id} - [DONO] Remove jogador do time.

### 6.5. Partidas e Calendario (/partidas)
- POST /campeonatos/{id}/gerar-calendario - [DONO] Gera rodadas automaticamente via motor Python de Round-Robin ou Chaveamento.
- GET /campeonatos/{id}/partidas - Lista agenda completa com paginacao e rodadas.
- POST /campeonatos/{id}/partidas - [DONO] Criacao avulsa e manual de uma partida.
- GET /partidas/{id} - Detalhes do duelo.
- PUT /partidas/{id} - [DONO] Altera data/local (vetado se FINALIZADA).
- DELETE /partidas/{id} - [DONO] Cancela partida pre-agendada.

### 6.6. Resultados e Eventos (/partidas/{id}/resultado)
- POST /partidas/{id}/resultado - [DONO] Grava o placar isolado, sobe o array de eventos (Gols, Cartoes) e chancela a partida como FINALIZADA.
- GET /partidas/{id}/sumula - Constroi a sumula rasteada da partida finalizada.

### 6.7. Estatisticas Calculadas (/campeonatos/{id}/...)
Calculado em Dataframes sob-demanda com base em partidas finalizadas:
- GET /campeonatos/{id}/classificacao - A Tabela Oficial rastreada com desempate por gols.
- GET /campeonatos/{id}/estatisticas-gerais - Dados gerais (total de gols, media, maiores goleadas).
- GET /campeonatos/{id}/artilharia - Ranking de goleadores baseado em minutagem e chuteiras de ouro.
- GET /campeonatos/{id}/estatisticas-times - Times com melhor ofensiva ou defesa impenetravel.

### 6.8. Busca Global (/busca)
- GET /busca?q={termo}&tipo={todos|time|jogador|campeonato} - Varredura agnostica.

### 6.9. Co-Administradores (/campeonatos/{id}/administradores)
- GET /campeonatos/{id}/administradores - Lista de co-administradores da liga.
- POST /campeonatos/{id}/administradores - [DONO] Delega direitos administrativos de moderacao a outros usuarios registrados.
- DELETE /campeonatos/{id}/administradores/{usuario_id} - [DONO] Revoga direitos.

## 7. Variaveis de Ambiente Base

Backend (back_gestao_ligas/.env):
```env
SECRET_KEY=troque-por-um-valor-seguro
JWT_SECRET_KEY=troque-por-outro-valor-seguro
SQLALCHEMY_DATABASE_URI=sqlite:///gestao_ligas.db
CORS_ORIGINS=*
```

## 8. Fluxo de Validacao QA

1. Subir backend e validar GET /v1/health.
2. Abrir app e registrar uma conta de administrador.
3. Criar a Liga Principal.
4. Cadastrar 4 times e jogadores ficticios.
5. Pressionar a auto-geracao de Calendario de Pontos Corridos.
6. Gravar vitórias e cartões em resultados.
7. Validar a atualização simultanea das telas de Tabela de Classificacao e Painel de Artilharia.
8. Retornar ao painel de edicao e decretar o Encerramento da Liga coroando o campeao.
9. Validar blindagem que impede subverter resultados de campeonatos selados.

## 9. Instrucoes de Build / Relase

### Android
```bash
cd front_gestao_ligas
# Gerar APK avulso
flutter build apk --release

# Gerar AAB para a Google Play Store
flutter build appbundle --release
```
Ao compilar o release para lojas de aplicativo, nao esqueca a arvore de chaves JKS:
- `ANDROID_KEYSTORE_PATH`
- `ANDROID_KEYSTORE_PASSWORD`
- `ANDROID_KEY_ALIAS`
- `ANDROID_KEY_PASSWORD`

### Web 
```bash
cd front_gestao_ligas
flutter build web --release
```

## 10. Testes de Qualidade

```bash
# Frontend
cd front_gestao_ligas && flutter analyze && flutter test

# Backend
cd back_gestao_ligas && python -m pytest
```

## 11. Troubleshooting Comum

Conexão muda no Loading:
- Tratamento silencioso comum do Flutter quando o endpoint é inválido ou a porta 5005 caiu no background do Mac/Windows. Verifique com `lsof -i :5005`.

Regras Inconsistentes de API:
- Para times operando via Celular Físico certifique-se de forçar a `--dart-define=API_HOST` e garantir que `CORS_ORIGINS=*` na raiz do seu back-end em `.env`.

Credenciais Negadas ou 401s:
- Tokens JWT possuem expirações firmadas em rotacionais curtos de segurança, um re-login simples purga e instaura um novo token assinado de sessão na memória cache.

## 12. Screenshots In-App

<img src="https://github.com/user-attachments/assets/3f490055-5870-49ba-b831-90bc1736dac1" width="250"/>
<img src="https://github.com/user-attachments/assets/3ca256c2-a80d-4b6f-9295-245624b2e925" width="250"/>
<img src="https://github.com/user-attachments/assets/4c4e5ee9-2b1b-4810-a8d3-89d2856c5fb0" width="250"/>
<img src="https://github.com/user-attachments/assets/44195e8c-fbe8-4ba4-a14d-1cf61f9ab30e" width="250"/>
<img src="https://github.com/user-attachments/assets/96eedd80-7709-4da6-9e1d-30f01d017fc4" width="250"/>
<img src="https://github.com/user-attachments/assets/4ff08ee6-ec5f-4d06-b46f-05ebe0eff194" width="250"/>
<img src="https://github.com/user-attachments/assets/8536d431-6a31-4c63-905e-f1204179d3c0" width="250"/>
