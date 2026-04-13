import 'package:flutter/material.dart';
import 'package:front_gestao_ligas/data/database/repositories/campeonato_repository.dart';
import '../models/models.dart';

/// Estado de campeonatos (RF 03, RF 14, RF 15)
class CampeonatoProvider extends ChangeNotifier {
  final CampeonatoRepository _repo;

  List<Campeonato> _campeonatos = [];
  Campeonato? _campeonatoAtual;
  bool _isLoading = false;
  String? _error;
  String _busca = '';

  CampeonatoProvider(this._repo);

  List<Campeonato> get campeonatos => _campeonatos;
  Campeonato? get campeonatoAtual => _campeonatoAtual;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get busca => _busca;

  /// Listar campeonatos com busca (RF 15)
  Future<void> listar({String? busca}) async {
    _isLoading = true;
    _error = null;
    _busca = busca ?? '';
    notifyListeners();

    try {
      _campeonatos = await _repo.listar(busca: busca);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Buscar campeonato por ID
  Future<void> buscarPorId(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _campeonatoAtual = await _repo.buscarPorId(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Criar campeonato (RF 03)
  Future<bool> criar(Map<String, dynamic> dados) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final novo = await _repo.criar(dados);
      _campeonatos.insert(0, novo);
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

  /// Editar campeonato (RF 03)
  Future<bool> editar(int id, Map<String, dynamic> dados) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final atualizado = await _repo.editar(id, dados);
      final idx = _campeonatos.indexWhere((c) => c.id == id);
      if (idx >= 0) _campeonatos[idx] = atualizado;
      if (_campeonatoAtual?.id == id) _campeonatoAtual = atualizado;
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

  /// Excluir campeonato (RF 03)
  Future<bool> excluir(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repo.excluir(id);
      _campeonatos.removeWhere((c) => c.id == id);
      if (_campeonatoAtual?.id == id) {
        _campeonatoAtual = null;
      }
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

  /// Encerrar campeonato (RF 14)
  Future<bool> encerrar(int id, int campeaoTimeId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repo.encerrar(id, campeaoTimeId);
      await buscarPorId(id);
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
