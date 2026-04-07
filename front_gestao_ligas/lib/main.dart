import 'package:flutter/material.dart';
import 'package:front_gestao_ligas/data/database/database.dart';
import 'package:front_gestao_ligas/data/database/repositories/campeonato_repository.dart';
import 'package:front_gestao_ligas/data/database/repositories/classificacao_repository.dart';
import 'package:front_gestao_ligas/data/database/repositories/partida_repository.dart';
import 'package:front_gestao_ligas/data/database/repositories/time_repository.dart';
import 'package:front_gestao_ligas/data/database/repositories/usuario_repository.dart';
import 'package:provider/provider.dart';
import 'core/theme.dart';
import 'core/router/app_router.dart';
import 'data/api_client.dart';
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
  late final AppDatabase _database;

  // Repositórios
  late final UsuarioRepository _authRepo;
  late final CampeonatoRepository _campeonatoRepo;
  late final TimeRepository _timeRepo;
  late final PartidaRepository _partidaRepo;
  late final ClassificacaoRepository _classificacaoRepo;

  @override
  void initState() {
    super.initState();

    _database = AppDatabase();
    _apiClient = ApiClient();

    _authRepo = UsuarioRepository(dao: _database.usuarioDao, api: _apiClient);
    _campeonatoRepo = CampeonatoRepository(dao: _database.campeonatoDao, api: _apiClient);
    _timeRepo = TimeRepository(dao: _database.timeDao, api: _apiClient);
    _partidaRepo = PartidaRepository(dao: _database.partidaDao, campeonatoRepository: _campeonatoRepo, api: _apiClient);
    _classificacaoRepo = ClassificacaoRepository(dao: _database.campeonatoDao, api: _apiClient);

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
        ChangeNotifierProvider(create: (_) => JogadorProvider(_timeRepo)),
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
