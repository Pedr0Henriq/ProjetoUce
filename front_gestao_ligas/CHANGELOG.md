# Changelog

Todas as mudanças notáveis do projeto **Gestão de Ligas** são documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/).

---

## [Unreleased]

### Adicionado
- **RF 12 — Tela de Perfil do Usuário** (`/perfil`): permite editar nome, e-mail e senha
  diretamente no aplicativo. Acessível pelo botão de perfil na AppBar da tela principal.
- **RF 13 — Histórico de Partidas**: seção "Histórico de Partidas" na ficha do time,
  exibindo resultados finalizados com placar, chip colorido (Vitória/Empate/Derrota) e
  navegação para a súmula de cada partida.
- **RF 17 — Administradores Adicionais** (`/campeonato/:id/administradores`): tela para
  gerenciar co-administradores de um campeonato; adiciona por e-mail e remove com
  confirmação. Visível apenas para Administradores no menu do painel.
- **Splash Screen** com animação de escala + fade do logo e do nome do aplicativo antes
  de navegar para a tela principal.
- **Widget `AppLogo`** (`lib/widgets/app_logo.dart`): widget reutilizável do logo com
  suporte a tamanho configurável e exibição opcional do nome do app.
- **Constantes de animação** em `AppTheme`: `animFast`, `animNormal`, `animSlow`,
  `splashDuration`, `animCurveStandard`, `animCurveEnter`, `animCurveSpring`.
- Botão de acesso ao perfil (`account_circle_outlined`) na AppBar da tela de campeonatos.
- Métodos RF 17 em `UsuarioRepository` e `AuthProvider`:
  `listarAdministradoresCampeonato`, `adicionarAdministrador`, `removerAdministrador`.
- Rota `/splash` (pública), `/perfil` e `/campeonato/:id/administradores` no GoRouter.

### Modificado
- **Login Screen**: substituído o bloco de logo inline pelo widget `AppLogo` (consistência
  visual com o splash); adicionado gradiente sutil no fundo (verde 7% → branco).
- **`CampeonatosScreen`**: empty state agora exibe botão "Criar Campeonato" para admins
  quando não há campeonatos; subtítulo adaptado por perfil e estado de busca.
- **`CampeonatoPainelScreen`**: menu de admin inclui nova opção "Administradores" (RF 17).
- **`AppRouter`**: `initialLocation` alterado de `/login` para `/splash`; guard de
  redirecionamento atualizado para não bloquear a rota de splash.
- **`TimeFichaScreen`**: adicionadas seção de histórico e classes `_PartidaHistoricoTile`
  e `_ResultadoChip`.
- **`UsuarioRepository`**: documentação `/// RF 17` nos três novos métodos.
- **`AuthProvider`**: documentação `/// RF 17` nos três novos métodos delegadores.

---

## [1.0.0] — 2026-04-07

### Adicionado
- **RF 01 — Autenticar Usuário**: login por e-mail e senha com recuperação de senha.
- **RF 02 — Controlar Permissões por Perfil**: restrição de funcionalidades por
  Administrador / Analista via `auth.isAdmin` em todos os botões de ação.
- **RF 03 — Criar e Gerenciar Campeonatos**: CRUD completo (criar, editar, encerrar,
  excluir) com campo de busca em tempo real.
- **RF 04 — Registrar Resultados de Partidas**: placar e eventos (gols, assistências,
  cartões) com confirmação antes de finalizar.
- **RF 05 — Cadastrar e Gerenciar Times**: cadastro com nome, escudo e localidade.
- **RF 06 — Cadastrar e Gerenciar Jogadores**: cadastro com nome, posição e número (opcional).
- **RF 07 — Gerar Calendário Automaticamente**: geração Round-Robin via backend (Flask).
- **RF 08 — Cadastrar e Gerenciar Partidas**: visualização por rodada, com data, horário
  e placar; acesso ao registro de resultado e à súmula.
- **RF 09 — Gerar Classificação Automática**: tabela J/V/E/D/GP/GC/SG/PTS calculada pelo
  backend e exibida na aba Classificação.
- **RF 10 — Exibir Estatísticas Básicas**: ranking de artilheiros e assistentes na aba
  Artilharia.
- **RF 11 — Encerrar Sessão**: logout com limpeza do token JWT.
- **RF 14 — Encerrar Campeonato**: opção no menu do painel com confirmação (NF 04).
- **RF 15 — Buscar Campeonatos**: pesquisa em tempo real na tela principal.
- **RF 16 — Gerenciar Súmula Eletrônica**: súmula com linha do tempo de eventos, escalações
  e placar final; acessível a todos os perfis.
- Arquitetura Flutter com Provider, GoRouter, Drift ORM e API REST (Flask + PostgreSQL).
- Tema Material Design 3 com paleta verde-escuro + amarelo (`AppTheme`).
- Componentes reutilizáveis: `EmptyState`, `LoadingState`, `ErrorState`, `TeamShield`,
  `StatusChip`, `DialogHelper`.
- Validadores de formulário (`Validators`) e formatadores de data (`DateFormatters`).
- Cliente HTTP centralizado (`ApiClient`) com JWT, timeout e tratamento de erros (NF 14).
- Banco de dados local Drift para cache offline básico.
