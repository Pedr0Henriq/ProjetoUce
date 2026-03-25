import 'package:flutter/material.dart';
import 'package:front_gestao_ligas/data/database/repositories/time_repository.dart';
import '../models/models.dart';

/// Estado de times (RF 05)
class TimeProvider extends ChangeNotifier {
  final TimeRepository _repo;

  List<Time> _times = [];
  Time? _timeAtual;
  bool _isLoading = false;
  String? _error;

  TimeProvider(this._repo);

  List<Time> get times => _times;
  Time? get timeAtual => _timeAtual;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> listarPorCampeonato(int campeonatoId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _times = await _repo.buscarTimesPorCampeonato(campeonatoId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> buscarPorId(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _timeAtual = await _repo.buscarPorId(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> criar(Map<String, dynamic> dados) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final novo = await _repo.criar(dados);
      _times.add(novo);
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

  Future<bool> editar(int id, Map<String, dynamic> dados) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final atualizado = await _repo.editar(id, dados);
      final idx = _times.indexWhere((t) => t.id == id);
      if (idx >= 0) _times[idx] = atualizado;
      if (_timeAtual?.id == id) _timeAtual = atualizado;
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

  Future<bool> excluir(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repo.excluir(id);
      _times.removeWhere((t) => t.id == id);
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
