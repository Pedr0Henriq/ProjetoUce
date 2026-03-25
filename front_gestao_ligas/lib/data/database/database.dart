import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:front_gestao_ligas/data/database/daos/campeonato_dao.dart';
import 'package:front_gestao_ligas/data/database/daos/partida_dao.dart';
import 'package:front_gestao_ligas/data/database/daos/time_dao.dart';
import 'package:front_gestao_ligas/data/database/daos/usuario_dao.dart';
import 'package:front_gestao_ligas/data/database/tables/core_tables.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Usuarios,
    Campeonatos,
    Times,
    Jogadores,
    Partidas,
    Classificacoes,
    EventosPartidas,
    Resultados,
  ],
  daos: [PartidaDao, CampeonatoDao, TimeDao, UsuarioDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'torneio_db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
