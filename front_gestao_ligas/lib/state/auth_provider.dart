import 'package:flutter/material.dart';
import '../data/api_client.dart';
import '../data/repositories.dart';
import '../models/models.dart';

/// Estado de autenticação (RF 01, RF 02, RF 11, RF 12)
class AuthProvider extends ChangeNotifier {
  final AuthRepository _repo;
  final ApiClient _apiClient;

  Usuario? _usuario;
  bool _isLoading = false;
  String? _error;
  bool _isAuthenticated = false;

  AuthProvider(this._repo, this._apiClient);

  Usuario? get usuario => _usuario;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _isAuthenticated;
  bool get isAdmin => _usuario?.isAdmin ?? false;

  /// Verificar se já há sessão ativa
  Future<void> checkAuth() async {
    final hasToken = await _apiClient.hasToken();
    if (hasToken) {
      try {
        _usuario = await _repo.getPerfil();
        _isAuthenticated = true;
      } catch (_) {
        await _apiClient.clearToken();
        _isAuthenticated = false;
      }
    }
    notifyListeners();
  }

  /// Login (RF 01)
  Future<bool> login(String email, String senha) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _repo.login(email, senha);
      final token = response['token'] as String;
      await _apiClient.saveToken(token);
      _usuario = Usuario.fromJson(response['usuario'] as Map<String, dynamic>);
      _isAuthenticated = true;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Logout (RF 11)
  Future<void> logout() async {
    await _repo.logout();
    _usuario = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  /// Recuperar senha (RF 01)
  Future<bool> recuperarSenha(String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repo.recuperarSenha(email);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Atualizar perfil (RF 12)
  Future<bool> atualizarPerfil(Map<String, dynamic> dados) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repo.atualizarPerfil(dados);
      _usuario = await _repo.getPerfil();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
