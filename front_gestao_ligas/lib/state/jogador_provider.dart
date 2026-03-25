import 'package:flutter/material.dart';
import 'package:front_gestao_ligas/data/database/repositories/time_repository.dart';
import '../models/models.dart';

/// Estado de jogadores (RF 06)
class JogadorProvider extends ChangeNotifier {
  final TimeRepository _repo;

  List<Jogador> _jogadores = [];
  bool _isLoading = false;
  String? _error;

  JogadorProvider(this._repo);

  List<Jogador> get jogadores => _jogadores;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> listarPorTime(int timeId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _jogadores = await _repo.listarJogadores(timeId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> criar(int timeId, Map<String, dynamic> dados) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final novo = await _repo.adicionarJogador(timeId, dados);
      _jogadores.add(novo);
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
      final atualizado = await _repo.editarJogador(id, dados);
      final idx = _jogadores.indexWhere((j) => j.id == id);
      if (idx >= 0) _jogadores[idx] = atualizado;
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
      await _repo.removerJogador(id);
      _jogadores.removeWhere((j) => j.id == id);
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
