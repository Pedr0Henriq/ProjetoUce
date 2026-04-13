# Frontend Flutter - Gestao de Ligas

Aplicativo Flutter para consumo da API do projeto, com foco em gerenciamento de campeonatos, partidas e estatisticas.

## 0. Autenticacao e Perfis

- Cadastro publico disponivel na tela "Criar Conta"
- Novas contas sao sempre criadas como Visualizador (Analista)
- Acoes de escrita/configuracao/exclusao ficam restritas a Administrador
- Rotas administrativas no app sao bloqueadas para visualizador

## 1. Requisitos

- Flutter SDK 3.24+
- Dart SDK compativel
- Android Studio (build Android)

## 2. Instalacao

```bash
cd front_gestao_ligas
flutter pub get
```

## 3. Configuracao de API

O app usa `--dart-define` para host/porta da API.

Parametros:
- `API_HOST`
- `API_PORT`

Default atual:
- Android Emulator: `10.0.2.2:5005`
- Web: `localhost:5005`

Exemplo para celular fisico na mesma rede:

```bash
flutter run --dart-define=API_HOST=192.168.1.50 --dart-define=API_PORT=5005
```

## 4. Execucao

### Android Emulator

```bash
flutter run
```

### Celular fisico

```bash
flutter run --dart-define=API_HOST=SEU_IP --dart-define=API_PORT=5005
```

### Web

```bash
flutter run -d chrome --dart-define=API_HOST=localhost --dart-define=API_PORT=5005
```

## 5. Build

### APK release

```bash
flutter build apk --release
```

### AAB release

```bash
flutter build appbundle --release
```

Para assinatura release real, defina as variaveis:
- `ANDROID_KEYSTORE_PATH`
- `ANDROID_KEYSTORE_PASSWORD`
- `ANDROID_KEY_ALIAS`
- `ANDROID_KEY_PASSWORD`

### Web release

```bash
flutter build web --release
```

## 6. Qualidade

```bash
flutter analyze
flutter test
```

## 7. Estrutura Principal

- `lib/core/`: tema, constantes, utils e roteamento
- `lib/data/`: cliente API, drift e repositorios
- `lib/state/`: providers
- `lib/screens/`: telas e widgets de interface
- `test/`: testes de widget

## 8. Troubleshooting

### App nao conecta na API
- confirme backend ativo em `http://HOST:5005/v1/health`
- ajuste `API_HOST` conforme dispositivo
- em celular fisico, nao use `localhost`

### Sessao expirada
- refaca login

### Nao encontro o cadastro
- na tela de login, toque em "Nao tem conta? Criar conta"
- apos criar a conta, faca login normalmente

### Erro de CORS na Web
- ajuste `CORS_ORIGINS` no backend