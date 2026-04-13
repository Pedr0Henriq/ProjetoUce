# Gestao de Ligas

Sistema mobile/web para organizacao de campeonatos esportivos comunitarios.

Este repositorio contem:

- backend REST em Flask + SQLAlchemy
- frontend Flutter (Android, Web e desktop)
- artefatos de requisitos do projeto

## 1. Visao Geral

O sistema cobre os fluxos principais do documento de requisitos:

- autenticacao e perfis
- gestao de campeonatos, times, jogadores e partidas
- registro de resultados e eventos
- classificacao, artilharia e sumula eletronica
- encerramento de campeonato com definicao de campeao

## 2. Estrutura do Repositorio

```text
ProjetoUce/
  back_gestao_ligas/      API Flask
  front_gestao_ligas/     App Flutter
  requisitos_extraido.txt requisitos em texto
  Gestao de Ligas - Documento de Requisitos.pdf
```

## 3. Pre-Requisitos

### 3.1 Backend

- Python 3.10+
- pip 23+

### 3.2 Frontend

- Flutter SDK 3.24+
- Dart SDK compativel com o Flutter instalado
- Android Studio (se for gerar APK/AAB)

### 3.3 Ambiente

- Windows 10/11 ou Linux
- Porta 5005 livre (backend)

## 4. Implantacao Local (Academica)

## 4.1 Backend - Flask

No terminal, entre na pasta do backend:

```bash
cd back_gestao_ligas
```

Crie e ative o ambiente virtual:

```bash
python -m venv .venv
```

Windows (PowerShell):

```bash
.venv\Scripts\Activate.ps1
```

Windows (cmd):

```bash
.venv\Scripts\activate.bat
```

Linux/macOS:

```bash
source .venv/bin/activate
```

Instale dependencias:

```bash
pip install -r requirements.txt
```

Crie o arquivo de ambiente:

```bash
copy .env.example .env
```

Para Linux/macOS:

```bash
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

Resposta esperada:

```json
{"status":"ok","versao":"1.1.0"}
```

## 4.2 Frontend - Flutter

Em outro terminal, entre na pasta do app:

```bash
cd front_gestao_ligas
flutter pub get
```

### Execucao no Android Emulator

```bash
flutter run
```

Observacao:

- o host padrao da API no app e `10.0.2.2` (Android Emulator)

### Execucao em celular fisico (mesma rede)

Substitua o host da API pelo IP da maquina que roda o backend:

```bash
flutter run --dart-define=API_HOST=192.168.1.50 --dart-define=API_PORT=5005
```

### Execucao Web

```bash
flutter run -d chrome --dart-define=API_HOST=localhost --dart-define=API_PORT=5005
```

## 5. Variaveis de Ambiente Importantes

Backend (`back_gestao_ligas/.env`):

- `SECRET_KEY`
- `JWT_SECRET_KEY`
- `SQLALCHEMY_DATABASE_URI`
- `CORS_ORIGINS`

Exemplo local simples:

```env
SECRET_KEY=troque-por-um-valor-seguro
JWT_SECRET_KEY=troque-por-outro-valor-seguro
SQLALCHEMY_DATABASE_URI=sqlite:///gestao_ligas.db
CORS_ORIGINS=*
```

## 6. Fluxo de Validacao da Entrega

Use este roteiro para validar a aplicacao ponta a ponta:

1. Subir backend e validar `GET /v1/health`.
2. Abrir app e fazer login.
3. Criar campeonato.
4. Cadastrar times e jogadores.
5. Gerar calendario.
6. Registrar resultado com eventos.
7. Confirmar classificacao e artilharia atualizadas.
8. Abrir sumula de partida finalizada.
9. Encerrar campeonato (com campeao da classificacao).
10. Tentar novo registro de resultado no campeonato encerrado e validar bloqueio.

## 7. Build para Entrega

### Android APK (release)

```bash
cd front_gestao_ligas
flutter build apk --release
```

### Android AAB (Play Store)

```bash
cd front_gestao_ligas
flutter build appbundle --release
```

Para assinatura release, configure variaveis:

- `ANDROID_KEYSTORE_PATH`
- `ANDROID_KEYSTORE_PASSWORD`
- `ANDROID_KEY_ALIAS`
- `ANDROID_KEY_PASSWORD`

### Web Release

```bash
cd front_gestao_ligas
flutter build web --release
```

## 8. Comandos de Qualidade

Frontend:

```bash
cd front_gestao_ligas
flutter analyze
flutter test
```

Backend (sanidade):

```bash
cd back_gestao_ligas
python run.py
```

## 9. Troubleshooting

### Erro de conexao no app

- confirme se backend esta ativo na porta 5005
- valide host/porta em `--dart-define`
- para celular fisico, use IP da maquina, nao `localhost`

### CORS bloqueando chamadas

- ajuste `CORS_ORIGINS` no `.env`
- em desenvolvimento local, `CORS_ORIGINS=*`

### Token expirado

- faca logout/login novamente

### Android release assina com debug

- configure as variaveis de keystore release antes do build

## 10. Referencias

- Documento base: `Gestao de Ligas - Documento de Requisitos.pdf`
- Versao em texto: `requisitos_extraido.txt`
- Backend README: `back_gestao_ligas/README.md`
- Frontend README: `front_gestao_ligas/README.md`

## 11. Screenshots

<img src="https://github.com/user-attachments/assets/3f490055-5870-49ba-b831-90bc1736dac1" width="250"/>

<img src="https://github.com/user-attachments/assets/3ca256c2-a80d-4b6f-9295-245624b2e925" width="250"/>

<img src="https://github.com/user-attachments/assets/4c4e5ee9-2b1b-4810-a8d3-89d2856c5fb0" width="250"/>

<img src="https://github.com/user-attachments/assets/44195e8c-fbe8-4ba4-a14d-1cf61f9ab30e" width="250"/>
