import 'package:flutter/foundation.dart' show kIsWeb;

/// Constantes da aplicação
class AppConstants {
  AppConstants._();

  // API — detecta plataforma automaticamente
  // Para dispositivo físico Android, usar o IP da máquina na rede local
  static const String _hostIP = '192.168.1.5'; // IP da máquina na rede (Ethernet/Wi-Fi)

  static String get apiBaseUrl {
    if (kIsWeb) {
      return 'http://localhost:5000/v1'; // Flutter Web
    }
    // Android (físico ou emulator) e demais plataformas → IP da rede local
    return 'http://$_hostIP:5000/v1';
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
