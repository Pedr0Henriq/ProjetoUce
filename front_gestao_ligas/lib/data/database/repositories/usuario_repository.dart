import 'package:drift/drift.dart';
import 'package:front_gestao_ligas/data/api_client.dart';
import 'package:front_gestao_ligas/data/database/daos/usuario_dao.dart';
import 'package:front_gestao_ligas/data/database/database.dart' as db;
import 'package:front_gestao_ligas/models/usuario.dart' as domain;

/// Repositório de autenticação (RF 01, RF 02, RF 11, RF 12)
class UsuarioRepository {
  final UsuarioDao dao;
  final ApiClient api;

  UsuarioRepository({required this.dao, required this.api});

  domain.Usuario _mapUsuarioToDomain(db.Usuario data) {
    return domain.Usuario(
      id: data.id,
      nome: data.nome,
      email: data.email,
      perfil: data.perfil == 'administrador'
          ? domain.PerfilUsuario.administrador
          : domain.PerfilUsuario.analista,
      criadoEm: data.criadoEm,
    );
  }

  db.UsuariosCompanion _domainToCompanion(domain.Usuario usuario) {
    return db.UsuariosCompanion(
      id: Value(usuario.id),
      nome: Value(usuario.nome),
      email: Value(usuario.email),
      perfil: Value(
        usuario.perfil == domain.PerfilUsuario.administrador
            ? 'ADMIN'
            : 'VIEWER',
      ),
      criadoEm: Value(usuario.criadoEm),
    );
  }

  Future<Map<String, dynamic>> login(String email, String senha) async {
    final response = await api.post('/auth/login', {
      'email': email,
      'senha': senha,
    });

    final data = response as Map<String, dynamic>;

    if (data.containsKey('usuario')) {
      final usuario = domain.Usuario.fromJson(data['usuario']);
      await dao.upsert(_domainToCompanion(usuario));
    }

    return data;
  }

  Future<void> logout() async {
    try {
      await api.post('/auth/logout', {});
    } catch (_) {}
    await api.clearToken();
  }

  Future<void> recuperarSenha(String email) async {
    await api.post('/auth/recuperar-senha', {'email': email});
  }

  Future<domain.Usuario> getPerfil() async {
    try {
      final response = await api.get('/auth/perfil');
      final usuarioApi = domain.Usuario.fromJson(
        response as Map<String, dynamic>,
      );

      await dao.atualizarUsuario(_domainToCompanion(usuarioApi));

      return usuarioApi;
    } catch (e) {
      final dadosDrift = await dao.obterTodosUsuarios();
      if (dadosDrift.isNotEmpty) {
        return _mapUsuarioToDomain(dadosDrift.first);
      }
      rethrow;
    }
  }

  Future<void> atualizarPerfil(Map<String, dynamic> dados) async {
    await api.put('/auth/perfil', dados);

    await getPerfil();
  }

  Future<List<domain.Usuario>> buscarTodosUsuarios() async {
    final dadosDrift = await dao.obterTodosUsuarios();
    return dadosDrift.map(_mapUsuarioToDomain).toList();
  }

  Future<domain.Usuario?> buscarUsuarioPorEmail(String email) async {
    final dadoDrift = await dao.obterUsuarioPorEmail(email);
    if (dadoDrift == null) return null;
    return _mapUsuarioToDomain(dadoDrift);
  }

  Future<void> criarUsuario(domain.Usuario usuario) async {
    final companion = db.UsuariosCompanion.insert(
      nome: usuario.nome,
      email: usuario.email,
      perfil: usuario.perfil == domain.PerfilUsuario.administrador
          ? 'administrador'
          : 'analista',
      criadoEm: usuario.criadoEm,
    );
    await dao.criarUsuario(companion);
  }

  // ── RF 17 — Administradores Adicionais ────────────────────────────────────

  /// RF 17 — Retorna todos os co-administradores de um campeonato.
  ///
  /// Endpoint: GET /campeonatos/:id/administradores
  Future<List<domain.Usuario>> listarAdministradoresCampeonato(
      int campeonatoId) async {
    final response = await api.get('/campeonatos/$campeonatoId/administradores');
    final list = response as List;
    return list
        .map((e) => domain.Usuario.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// RF 17 — Adiciona um usuário como co-administrador de um campeonato.
  ///
  /// Endpoint: POST /campeonatos/:id/administradores
  /// Body: `{ "email": "..." }`
  Future<void> adicionarAdministrador(
      int campeonatoId, String email) async {
    await api.post(
      '/campeonatos/$campeonatoId/administradores',
      {'email': email},
    );
  }

  /// RF 17 — Remove um co-administrador de um campeonato.
  ///
  /// Endpoint: DELETE /campeonatos/:id/administradores/:usuarioId
  Future<void> removerAdministrador(
      int campeonatoId, int usuarioId) async {
    await api.delete(
      '/campeonatos/$campeonatoId/administradores/$usuarioId',
    );
  }
}
