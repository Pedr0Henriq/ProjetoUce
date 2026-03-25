import 'package:flutter/material.dart';
import 'package:front_gestao_ligas/data/database/repositories/partida_repository.dart';
import '../models/models.dart';

/// Estado de partidas e resultados (RF 04, RF 07, RF 08, RF 13, RF 16)
class PartidaProvider extends ChangeNotifier {
  final PartidaRepository _repo;

  List<Partida> _partidas = [];
  Partida? _partidaAtual;
  List<EventoPartida> _eventosPartida = [];
  bool _isLoading = false;
  String? _error;

  PartidaProvider(this._repo);

  List<Partida> get partidas => _partidas;
  Partida? get partidaAtual => _partidaAtual;
  List<EventoPartida> get eventosPartida => _eventosPartida;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Agrupar partidas por rodada
  Map<int, List<Partida>> get partidasPorRodada {
    final map = <int, List<Partida>>{};
    for (final p in _partidas) {
      map.putIfAbsent(p.rodada, () => []).add(p);
    }
    return Map.fromEntries(
      map.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
  }

  /// Listar partidas do campeonato
  Future<void> listarPorCampeonato(int campeonatoId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _partidas = await _repo.listarPorCampeonato(campeonatoId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Buscar partida por ID
  Future<void> buscarPorId(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _partidaAtual = await _repo.buscarPorId(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Gerar calendário automático (RF 07)
  Future<bool> gerarCalendario(int campeonatoId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repo.gerarCalendario(campeonatoId);
      await listarPorCampeonato(campeonatoId);
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Registrar resultado (RF 04)
  Future<bool> registrarResultado(
    int partidaId,
    Map<String, dynamic> resultado,
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repo.registrarResultado(partidaId, resultado);
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

  /// Listar eventos da partida (RF 16 — Súmula)
  Future<void> listarEventos(int partidaId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _eventosPartida = await _repo.listarEventos(partidaId);
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
