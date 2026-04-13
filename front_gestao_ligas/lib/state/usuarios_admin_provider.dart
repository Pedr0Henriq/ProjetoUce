import 'package:flutter/material.dart';
import 'package:front_gestao_ligas/data/database/repositories/usuario_repository.dart';
import 'package:front_gestao_ligas/models/usuario.dart';

class UsuariosAdminProvider extends ChangeNotifier {
  final UsuarioRepository _repo;

  UsuariosAdminProvider(this._repo);

  List<Usuario> _usuarios = [];
  bool _isLoading = false;
  String? _error;
  int? _usuarioEmAcao;

  List<Usuario> get usuarios => _usuarios;
  bool get isLoading => _isLoading;
  String? get error => _error;

  bool usuarioEstaProcessando(int usuarioId) => _usuarioEmAcao == usuarioId;

  Future<void> carregarUsuarios() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _usuarios = await _repo.listarUsuariosAdmin();
      _ordenarUsuarios();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> promoverUsuario(int usuarioId) async {
    _usuarioEmAcao = usuarioId;
    _error = null;
    notifyListeners();

    try {
      final usuarioAtualizado = await _repo.promoverUsuario(usuarioId);
      _atualizarUsuarioNaLista(usuarioAtualizado);
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _usuarioEmAcao = null;
      notifyListeners();
    }
  }

  Future<bool> desativarUsuario(int usuarioId) async {
    _usuarioEmAcao = usuarioId;
    _error = null;
    notifyListeners();

    try {
      final usuarioAtualizado = await _repo.desativarUsuario(usuarioId);
      _atualizarUsuarioNaLista(usuarioAtualizado);
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _usuarioEmAcao = null;
      notifyListeners();
    }
  }

  void limparErro() {
    _error = null;
    notifyListeners();
  }

  void _atualizarUsuarioNaLista(Usuario usuarioAtualizado) {
    _usuarios = _usuarios
        .map((u) => u.id == usuarioAtualizado.id ? usuarioAtualizado : u)
        .toList();
    _ordenarUsuarios();
  }

  void _ordenarUsuarios() {
    _usuarios.sort(
      (a, b) {
        final ativoCmp = (b.ativo ? 1 : 0).compareTo(a.ativo ? 1 : 0);
        if (ativoCmp != 0) return ativoCmp;

        final adminCmp = (b.isAdmin ? 1 : 0).compareTo(a.isAdmin ? 1 : 0);
        if (adminCmp != 0) return adminCmp;

        return a.nome.toLowerCase().compareTo(b.nome.toLowerCase());
      },
    );
  }
}
