import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/constants.dart';

/// Exceção personalizada para erros da API
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

/// Cliente HTTP centralizado para comunicação com a API REST (NF 14)
class ApiClient {
  final http.Client _client;
  final FlutterSecureStorage _storage;

  ApiClient({http.Client? client, FlutterSecureStorage? storage})
      : _client = client ?? http.Client(),
        _storage = storage ?? const FlutterSecureStorage();

  String get _baseUrl => AppConstants.apiBaseUrl;

  Future<Map<String, String>> _headers() async {
    final token = await _storage.read(key: AppConstants.tokenKey);
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _client
          .get(
            Uri.parse('$_baseUrl$endpoint'),
            headers: await _headers(),
          )
          .timeout(AppConstants.apiTimeout);
      return _handleResponse(response);
    } on TimeoutException {
      throw ApiException(
        'Tempo de conexão esgotado. Tente novamente.',
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Erro de conexão: ${e.toString()}');
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await _client
          .post(
            Uri.parse('$_baseUrl$endpoint'),
            headers: await _headers(),
            body: jsonEncode(body),
          )
          .timeout(AppConstants.apiTimeout);
      return _handleResponse(response);
    } on TimeoutException {
      throw ApiException(
        'Tempo de conexão esgotado. Tente novamente.',
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Erro de conexão: ${e.toString()}');
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await _client
          .put(
            Uri.parse('$_baseUrl$endpoint'),
            headers: await _headers(),
            body: jsonEncode(body),
          )
          .timeout(AppConstants.apiTimeout);
      return _handleResponse(response);
    } on TimeoutException {
      throw ApiException(
        'Tempo de conexão esgotado. Tente novamente.',
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Erro de conexão: ${e.toString()}');
    }
  }

  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await _client
          .delete(
            Uri.parse('$_baseUrl$endpoint'),
            headers: await _headers(),
          )
          .timeout(AppConstants.apiTimeout);
      return _handleResponse(response);
    } on TimeoutException {
      throw ApiException(
        'Tempo de conexão esgotado. Tente novamente.',
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Erro de conexão: ${e.toString()}');
    }
  }

  dynamic _handleResponse(http.Response response) {
    final body = response.body.isNotEmpty ? jsonDecode(response.body) : null;

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }

    final message = body is Map
      ? body['message'] ?? body['error'] ?? body['erro']
      : null;

    switch (response.statusCode) {
      case 401:
        throw ApiException(
          message ?? 'Sessão expirada. Faça login novamente.',
          statusCode: 401,
        );
      case 403:
        throw ApiException(
          message ?? 'Você não tem permissão para esta operação.',
          statusCode: 403,
        );
      case 404:
        throw ApiException(
          message ?? 'Recurso não encontrado.',
          statusCode: 404,
        );
      case 422:
        throw ApiException(
          message ?? 'Dados inválidos. Verifique as informações.',
          statusCode: 422,
        );
      default:
        throw ApiException(
          message ?? 'Erro no servidor. Tente novamente mais tarde.',
          statusCode: response.statusCode,
        );
    }
  }

  /// Salvar token JWT
  Future<void> saveToken(String token) async {
    await _storage.write(key: AppConstants.tokenKey, value: token);
  }

  /// Remover token JWT (logout)
  Future<void> clearToken() async {
    await _storage.delete(key: AppConstants.tokenKey);
  }

  /// Verificar se existe token salvo
  Future<bool> hasToken() async {
    final token = await _storage.read(key: AppConstants.tokenKey);
    return token != null && token.isNotEmpty;
  }
}
