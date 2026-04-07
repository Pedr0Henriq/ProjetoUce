import 'package:flutter/material.dart';
import 'package:front_gestao_ligas/data/database/repositories/classificacao_repository.dart';
import '../models/models.dart';

/// Estado de classificação e estatísticas (RF 09, RF 10)
class ClassificacaoProvider extends ChangeNotifier {
  final ClassificacaoRepository _repo;

  List<Classificacao> _classificacao = [];

  /// Lista de artilheiros ordenada por gols (decrescente).
  List<Map<String, dynamic>> _artilheiros = [];

  /// Lista de assistentes ordenada por assistências (decrescente).
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

  /// RF 10 — Carrega artilheiros e assistentes a partir de uma única chamada à
  /// API, ordenando cada lista de forma independente:
  /// - artilheiros: por gols (desc)
  /// - assistências: por assistências (desc)
  ///
  /// Isso evita duas chamadas desnecessárias e garante que cada aba exiba os
  /// dados classificados pelo critério correto.
  Future<void> carregarArtilhariaEAssistencias(int campeonatoId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final dados = await _repo.artilhariaEAssistencia(campeonatoId);

      _artilheiros = List<Map<String, dynamic>>.from(dados)
        ..sort((a, b) => ((b['gols'] as num?) ?? 0)
            .compareTo((a['gols'] as num?) ?? 0));

      _assistencias = List<Map<String, dynamic>>.from(dados)
        ..sort((a, b) => ((b['assistencias'] as num?) ?? 0)
            .compareTo((a['assistencias'] as num?) ?? 0));

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Carregar classificação + artilharia de uma só vez (usado pelo painel).
  Future<void> carregarTudo(int campeonatoId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final classificacaoFut = _repo.buscarPorCampeonato(campeonatoId);
      final artilhariaFut = _repo.artilhariaEAssistencia(campeonatoId);

      final results = await Future.wait([classificacaoFut, artilhariaFut]);

      _classificacao = results[0] as List<Classificacao>;

      final dados = results[1] as List<Map<String, dynamic>>;
      _artilheiros = List<Map<String, dynamic>>.from(dados)
        ..sort((a, b) => ((b['gols'] as num?) ?? 0)
            .compareTo((a['gols'] as num?) ?? 0));
      _assistencias = List<Map<String, dynamic>>.from(dados)
        ..sort((a, b) => ((b['assistencias'] as num?) ?? 0)
            .compareTo((a['assistencias'] as num?) ?? 0));

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
