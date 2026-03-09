import 'package:go_router/go_router.dart';
import '../../state/auth_provider.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/recuperar_senha_screen.dart';
import '../../screens/campeonatos/campeonatos_screen.dart';
import '../../screens/campeonatos/criar_campeonato_screen.dart';
import '../../screens/campeonato/campeonato_painel_screen.dart';
import '../../screens/campeonato/editar_campeonato_screen.dart';
import '../../screens/partidas/registrar_resultado_screen.dart';
import '../../screens/partidas/sumula_screen.dart';
import '../../screens/campeonato/widgets/time_ficha_screen.dart';
import '../../screens/campeonato/widgets/criar_time_screen.dart';
import '../../screens/campeonato/widgets/jogador_form_screen.dart';

/// Configuração de rotas da aplicação com GoRouter
class AppRouter {
  final AuthProvider authProvider;

  AppRouter(this.authProvider);

  late final GoRouter router = GoRouter(
    initialLocation: '/login',
    refreshListenable: authProvider,
    redirect: (context, state) {
      final isAuthenticated = authProvider.isAuthenticated;
      final isLoginRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/recuperar-senha';

      if (!isAuthenticated && !isLoginRoute) {
        return '/login';
      }
      if (isAuthenticated && isLoginRoute) {
        return '/campeonatos';
      }
      return null;
    },
    routes: [
      // Auth
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/recuperar-senha',
        name: 'recuperar-senha',
        builder: (context, state) => const RecuperarSenhaScreen(),
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
