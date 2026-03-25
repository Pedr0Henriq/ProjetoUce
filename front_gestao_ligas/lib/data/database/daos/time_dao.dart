import 'package:drift/drift.dart';
import 'package:front_gestao_ligas/data/database/database.dart';
import 'package:front_gestao_ligas/data/database/tables/core_tables.dart';

part 'time_dao.g.dart';

@DriftAccessor(tables: [Times, Jogadores])
class TimeDao extends DatabaseAccessor<AppDatabase> with _$TimeDaoMixin {
  TimeDao(super.db);

  // --- Consultas ---
  Future<List<Time>> obterTimesPorCampeonato(int campeonatoId) =>
      (select(times)..where((tbl) => tbl.campeonatoId.equals(campeonatoId))).get();

  Future<Time?> obterTimePorId(int id) =>
      (select(times)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future<List<Jogadore>> obterJogadoresPorTime(int timeId) =>
      (select(jogadores)..where((tbl) => tbl.timeId.equals(timeId))).get();

  // --- Operações CRUD ---
  Future<int> criarTime(TimesCompanion entity) => into(times).insert(entity);
  Future<bool> atualizarTime(TimesCompanion entity) => update(times).replace(entity);
  Future<int> deletarTime(int id) => (delete(times)..where((tbl) => tbl.id.equals(id))).go();

  Future<int> adicionarJogador(JogadoresCompanion entity) => into(jogadores).insert(entity);
  Future<bool> atualizarJogador(JogadoresCompanion entity) => update(jogadores).replace(entity);
  Future<int> removerJogador(int id) => (delete(jogadores)..where((tbl) => tbl.id.equals(id))).go();
}