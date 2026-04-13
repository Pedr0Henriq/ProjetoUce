import 'package:go_router/go_router.dart';
import '../../state/auth_provider.dart';
import '../../screens/splash_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/cadastro_screen.dart';
import '../../screens/auth/recuperar_senha_screen.dart';
import '../../screens/perfil/perfil_screen.dart';
import '../../screens/campeonatos/campeonatos_screen.dart';
import '../../screens/campeonatos/criar_campeonato_screen.dart';
import '../../screens/campeonato/campeonato_painel_screen.dart';
import '../../screens/campeonato/editar_campeonato_screen.dart';
import '../../screens/campeonato/administradores_screen.dart';
import '../../screens/partidas/registrar_resultado_screen.dart';
import '../../screens/partidas/sumula_screen.dart';
import '../../screens/campeonato/widgets/time_ficha_screen.dart';
import '../../screens/campeonato/widgets/criar_time_screen.dart';
import '../../screens/campeonato/widgets/jogador_form_screen.dart';

/// Configuração de rotas da aplicação com GoRouter.
///
/// Rotas públicas (sem autenticação): /splash, /login, /register, /recuperar-senha
/// Rotas protegidas: todas as demais — redirecionam para /login se não autenticado.
class AppRouter {
  final AuthProvider authProvider;

  AppRouter(this.authProvider);

  late final GoRouter router = GoRouter(
    // Inicia no splash que exibe animação e navega automaticamente
    initialLocation: '/splash',
    refreshListenable: authProvider,
    redirect: (context, state) {
      final isAuthenticated = authProvider.isAuthenticated;
      final loc = state.matchedLocation;

      // Rotas públicas que não requerem autenticação
      final isPublicRoute = loc == '/login' ||
          loc == '/register' ||
          loc == '/recuperar-senha' ||
          loc == '/splash';

      // Rotas que exigem perfil administrador.
      final isAdminOnlyRoute =
          loc == '/campeonatos/criar' ||
          RegExp(r'^/campeonato/\d+/editar$').hasMatch(loc) ||
          RegExp(r'^/campeonato/\d+/administradores$').hasMatch(loc) ||
          RegExp(r'^/campeonato/\d+/criar-time$').hasMatch(loc) ||
          RegExp(r'^/campeonato/\d+/time/\d+/jogador$').hasMatch(loc) ||
          RegExp(r'^/campeonato/\d+/partida/\d+/resultado$').hasMatch(loc);

      if (!isAuthenticated && !isPublicRoute) {
        return '/login';
      }
      // Usuário autenticado tentando acessar login → redireciona para início
      if (isAuthenticated &&
          (loc == '/login' || loc == '/register' || loc == '/recuperar-senha')) {
        return '/campeonatos';
      }
      // Visualizador tentando acessar rota de escrita/configuração.
      if (isAuthenticated && !authProvider.isAdmin && isAdminOnlyRoute) {
        return '/campeonatos';
      }
      return null;
    },
    routes: [
      // Splash (público)
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Auth (público)
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const CadastroScreen(),
      ),
      GoRoute(
        path: '/recuperar-senha',
        name: 'recuperar-senha',
        builder: (context, state) => const RecuperarSenhaScreen(),
      ),

      // Perfil (RF 12)
      GoRoute(
        path: '/perfil',
        name: 'perfil',
        builder: (context, state) => const PerfilScreen(),
      ),

      // Campeonatos
      GoRoute(
        path: '/campeonatos',
        name: 'campeonatos',
        builder: (context, state) => const CampeonatosScreen(),
        routes: [
          GoRoute(
            path: 'criar',
            name: 'criar-campeonato',
            builder: (context, state) => const CriarCampeonatoScreen(),
          ),
        ],
      ),

      // Painel do Campeonato
      GoRoute(
        path: '/campeonato/:id',
        name: 'campeonato-painel',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return CampeonatoPainelScreen(campeonatoId: id);
        },
        routes: [
          GoRoute(
            path: 'editar',
            name: 'editar-campeonato',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return EditarCampeonatoScreen(campeonatoId: id);
            },
          ),
          // Administradores adicionais (RF 17)
          GoRoute(
            path: 'administradores',
            name: 'administradores-campeonato',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return AdministradoresScreen(campeonatoId: id);
            },
          ),
          GoRoute(
            path: 'time/:timeId',
            name: 'ficha-time',
            builder: (context, state) {
              final timeId = int.parse(state.pathParameters['timeId']!);
              final campId = int.parse(state.pathParameters['id']!);
              return TimeFichaScreen(timeId: timeId, campeonatoId: campId);
            },
          ),
          GoRoute(
            path: 'criar-time',
            name: 'criar-time',
            builder: (context, state) {
              final campId = int.parse(state.pathParameters['id']!);
              return CriarTimeScreen(campeonatoId: campId);
            },
          ),
          GoRoute(
            path: 'time/:timeId/jogador',
            name: 'criar-jogador',
            builder: (context, state) {
              final timeId = int.parse(state.pathParameters['timeId']!);
              return JogadorFormScreen(timeId: timeId);
            },
          ),
          GoRoute(
            path: 'partida/:partidaId/resultado',
            name: 'registrar-resultado',
            builder: (context, state) {
              final partidaId = int.parse(state.pathParameters['partidaId']!);
              return RegistrarResultadoScreen(partidaId: partidaId);
            },
          ),
          GoRoute(
            path: 'partida/:partidaId/sumula',
            name: 'sumula',
            builder: (context, state) {
              final partidaId = int.parse(state.pathParameters['partidaId']!);
              return SumulaScreen(partidaId: partidaId);
            },
          ),
        ],
      ),
    ],
  );
}
