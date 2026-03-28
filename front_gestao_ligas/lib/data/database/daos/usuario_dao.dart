import 'package:drift/drift.dart';
import 'package:front_gestao_ligas/data/database/database.dart';
import 'package:front_gestao_ligas/data/database/tables/core_tables.dart';

part 'usuario_dao.g.dart';

@DriftAccessor(tables: [Usuarios])
class UsuarioDao extends DatabaseAccessor<AppDatabase> with _$UsuarioDaoMixin {
  UsuarioDao(super.db);

  Future<List<Usuario>> obterTodosUsuarios() => select(usuarios).get();

  Future<Usuario?> obterUsuarioPorId(int id) =>
      (select(usuarios)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future<Usuario?> obterUsuarioPorEmail(String email) =>
      (select(usuarios)..where((tbl) => tbl.email.equals(email))).getSingleOrNull();

  Future<int> criarUsuario(UsuariosCompanion entity) => into(usuarios).insert(entity);
  Future<int> upsert(UsuariosCompanion entity) {
    return into(usuarios).insert(
      entity,
      onConflict: DoUpdate(
        (old) => entity,
        target: [usuarios.id]
      )
    );
  }
  Future<bool> atualizarUsuario(UsuariosCompanion entity) => update(usuarios).replace(entity);
  Future<int> deletarUsuario(int id) => (delete(usuarios)..where((tbl) => tbl.id.equals(id))).go();
}