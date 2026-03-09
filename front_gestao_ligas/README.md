# Estrutura do Projeto Flutter

## `lib/`

### `main.dart`
Entry point com Providers e Router.

---

## `core/`

| Arquivo | Descrição |
|--------|-----------|
| `constants.dart` | Constantes da API, storage keys e validações |
| `theme.dart` | Tema Material Design 3 (verde esportivo) |

### `core/router/`
| Arquivo | Descrição |
|--------|-----------|
| `app_router.dart` | GoRouter com todas as rotas e guards de autenticação |

### `core/utils/`
| Arquivo | Descrição |
|--------|-----------|
| `validators.dart` | Validadores de formulários *(NF 13)* |
| `date_formatters.dart` | Formatação de data/hora |
| `dialog_helper.dart` | Mensagens padronizadas e confirmações *(NF 03, NF 04)* |

---

## `models/`

| Arquivo | Descrição |
|--------|-----------|
| `models.dart` | Barrel export |
| `usuario.dart` | Entidade Usuário (Admin/Analista) |
| `campeonato.dart` | Entidade Campeonato |
| `time.dart` | Entidade Time |
| `jogador.dart` | Entidade Jogador |
| `partida.dart` | Entidade Partida |
| `resultado.dart` | Entidade Resultado |
| `evento_partida.dart` | Entidade EventoPartida |
| `classificacao.dart` | Entidade Classificação |

---

## `data/`

| Arquivo | Descrição |
|--------|-----------|
| `api_client.dart` | Cliente HTTP com JWT e tratamento de erros *(NF 10, NF 14)* |
| `repositories.dart` | Repositórios de Auth, Campeonato, Time, Jogador, Partida e Classificação |

---

## `state/`

| Arquivo | Descrição |
|--------|-----------|
| `auth_provider.dart` | Estado de autenticação *(RF 01, RF 02, RF 11, RF 12)* |
| `campeonato_provider.dart` | Estado de campeonatos *(RF 03, RF 14, RF 15)* |
| `time_provider.dart` | Estado de times *(RF 05)* |
| `jogador_provider.dart` | Estado de jogadores *(RF 06)* |
| `partida_provider.dart` | Estado de partidas *(RF 04, RF 07, RF 08, RF 13, RF 16)* |
| `classificacao_provider.dart` | Estado de classificação e estatísticas *(RF 09, RF 10)* |

---

## `screens/`

### `screens/widgets/`
| Arquivo | Descrição |
|--------|-----------|
| `state_widgets.dart` | Estados reutilizáveis: Empty, Loading e Error |
| `team_shield.dart` | Escudo do time com fallback |
| `status_chip.dart` | Chip de status (Em andamento / Encerrado) |

### `screens/auth/`
| Arquivo | Descrição |
|--------|-----------|
| `login_screen.dart` | Tela de Login *(Seção 4.1)* |
| `recuperar_senha_screen.dart` | Recuperação de Senha *(RF 01)* |

### `screens/campeonatos/`
| Arquivo | Descrição |
|--------|-----------|
| `campeonatos_screen.dart` | Lista de Campeonatos *(Seção 4.2)* |
| `criar_campeonato_screen.dart` | Criação de campeonato *(RF 03)* |

### `screens/campeonato/`
| Arquivo | Descrição |
|--------|-----------|
| `campeonato_painel_screen.dart` | Painel com 4 abas *(Seção 4.3)* |
| `editar_campeonato_screen.dart` | Edição de campeonato |

### `screens/campeonato/widgets/`
| Arquivo | Descrição |
|--------|-----------|
| `classificacao_tab.dart` | Aba Classificação *(RF 09)* |
| `partidas_tab.dart` | Aba Partidas por rodada *(RF 08)* |
| `artilharia_tab.dart` | Aba Artilheiros / Assistências *(RF 10)* |
| `times_tab.dart` | Aba Times *(RF 05)* |
| `time_ficha_screen.dart` | Ficha do Time + elenco *(Seção 4.5)* |
| `criar_time_screen.dart` | Cadastro de time |
| `jogador_form_screen.dart` | Cadastro de jogador *(RF 06)* |

### `screens/partidas/`
| Arquivo | Descrição |
|--------|-----------|
| `registrar_resultado_screen.dart` | Registro de resultado *(Seção 4.4, RF 04)* |
| `sumula_screen.dart` | Súmula Eletrônica *(Seção 4.6, RF 16)* |