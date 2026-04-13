import 'package:flutter/foundation.dart' show kIsWeb;

/// Constantes da aplicação
class AppConstants {
  AppConstants._();

  // API
  // Valores podem ser sobrescritos em runtime via --dart-define.
  // Exemplo: --dart-define=API_HOST=192.168.1.50 --dart-define=API_PORT=5005
  // Default para Android Emulator: 10.0.2.2
  static const String _hostIP = String.fromEnvironment(
    'API_HOST',
    defaultValue: '10.0.2.2',
  );
  static const String _port = String.fromEnvironment(
    'API_PORT',
    defaultValue: '5005',
  );

  static String get apiBaseUrl {
    if (kIsWeb) {
      return 'http://localhost:$_port/v1'; // Flutter Web
    }
    // Android (físico ou emulador) e demais plataformas
    return 'http://$_hostIP:$_port/v1';
  }

  static const Duration apiTimeout = Duration(seconds: 15);

  // Storage keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';

  // Paginação
  static const int defaultPageSize = 20;

  // Validações
  static const int senhaMinLength = 6;
  static const int nomeMaxLength = 100;
  static const int maxEquipesPorCampeonato = 32;
  static const int maxJogadoresPorTime = 30;
}
