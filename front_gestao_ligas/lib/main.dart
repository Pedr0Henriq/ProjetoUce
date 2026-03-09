import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme.dart';
import 'core/router/app_router.dart';
import 'data/api_client.dart';
import 'data/repositories.dart';
import 'state/auth_provider.dart';
import 'state/campeonato_provider.dart';
import 'state/classificacao_provider.dart';
import 'state/partida_provider.dart';
import 'state/time_provider.dart';
import 'state/jogador_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GestaoLigasApp());
}

class GestaoLigasApp extends StatefulWidget {
  const GestaoLigasApp({super.key});

  @override
  State<GestaoLigasApp> createState() => _GestaoLigasAppState();
}

class _GestaoLigasAppState extends State<GestaoLigasApp> {
  late final ApiClient _apiClient;
  late final AuthProvider _authProvider;
  late final AppRouter _appRouter;

  // Repositórios
  late final AuthRepository _authRepo;
  late final CampeonatoRepository _campeonatoRepo;
  late final TimeRepository _timeRepo;
  late final JogadorRepository _jogadorRepo;
  late final PartidaRepository _partidaRepo;
  late final ClassificacaoRepository _classificacaoRepo;

  @override
  void initState() {
    super.initState();

    _apiClient = ApiClient();

    _authRepo = AuthRepository(_apiClient);
    _campeonatoRepo = CampeonatoRepository(_apiClient);
    _timeRepo = TimeRepository(_apiClient);
    _jogadorRepo = JogadorRepository(_apiClient);
    _partidaRepo = PartidaRepository(_apiClient);
    _classificacaoRepo = ClassificacaoRepository(_apiClient);

    _authProvider = AuthProvider(_authRepo, _apiClient)..checkAuth();

    // Router criado UMA ÚNICA VEZ — usa refreshListenable para reagir
    _appRouter = AppRouter(_authProvider);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _authProvider),
        ChangeNotifierProvider(create: (_) => CampeonatoProvider(_campeonatoRepo)),
        ChangeNotifierProvider(create: (_) => TimeProvider(_timeRepo)),
        ChangeNotifierProvider(create: (_) => JogadorProvider(_jogadorRepo)),
        ChangeNotifierProvider(create: (_) => PartidaProvider(_partidaRepo)),
        ChangeNotifierProvider(
            create: (_) => ClassificacaoProvider(_classificacaoRepo)),
      ],
      child: MaterialApp.router(
        title: 'Gestão de Ligas',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: _appRouter.router,
      ),
    );
  }
}
