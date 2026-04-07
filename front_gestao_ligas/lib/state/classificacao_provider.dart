import 'package:flutter/material.dart';
import 'package:front_gestao_ligas/data/database/repositories/classificacao_repository.dart';
import '../models/models.dart';

/// Estado de classificação e estatísticas (RF 09, RF 10)
class ClassificacaoProvider extends ChangeNotifier {
  final ClassificacaoRepository _repo;

  List<Classificacao> _classificacao = [];
  List<Map<String, dynamic>> _artilheiros = [];
  List<Map<String, dynamic>> _assistencias = [];
  bool _isLoading = false;
  String? _error;

  ClassificacaoProvider(this._repo);

  List<Classificacao> get classificacao => _classificacao;
  List<Map<String, dynamic>> get artilheiros => _artilheiros;
  List<Map<String, dynamic>> get assistencias => _assistencias;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> buscarClassificacao(int campeonatoId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _classificacao = await _repo.buscarPorCampeonato(campeonatoId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> buscarArtilharia(int campeonatoId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _artilheiros = await _repo.artilhariaEAssistencia(campeonatoId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> buscarAssistencias(int campeonatoId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _assistencias = await _repo.artilhariaEAssistencia(campeonatoId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Carregar tudo de uma vez
  Future<void> carregarTudo(int campeonatoId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _repo.buscarPorCampeonato(campeonatoId),
        _repo.artilhariaEAssistencia(campeonatoId),
      ]);
      _classificacao = results[0] as List<Classificacao>;
      _artilheiros = results[1] as List<Map<String, dynamic>>;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
