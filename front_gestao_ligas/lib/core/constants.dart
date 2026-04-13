import 'package:flutter/foundation.dart' show kIsWeb;

/// Constantes da aplicação
class AppConstants {
  AppConstants._();

  // API
  // Valores podem ser sobrescritos em runtime via --dart-define.
  // Compatibilidade: também aceita API_BASE_URL completo.
  // Exemplo: --dart-define=API_HOST=192.168.1.50 --dart-define=API_PORT=5005
  // Exemplo alternativo: --dart-define=API_BASE_URL=http://192.168.1.50:5005/v1
  static const String _baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  );

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
    final explicitBaseUrl = _baseUrl.trim();
    if (explicitBaseUrl.isNotEmpty) {
      final normalized = explicitBaseUrl.endsWith('/')
          ? explicitBaseUrl.substring(0, explicitBaseUrl.length - 1)
          : explicitBaseUrl;
      return normalized.endsWith('/v1') ? normalized : '$normalized/v1';
    }

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
