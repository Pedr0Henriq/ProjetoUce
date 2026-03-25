import 'package:drift/drift.dart';
import 'package:front_gestao_ligas/data/database/database.dart';
import 'package:front_gestao_ligas/data/database/tables/core_tables.dart';

part 'campeonato_dao.g.dart';

// Classe auxiliar para mapear a Classificacao junto com os dados do Time
class ClassificacaoComDetalhes {
  final Classificacoe classificacao;
  final Time time;

  ClassificacaoComDetalhes({
    required this.classificacao,
    required this.time,
  });
}

@DriftAccessor(tables: [Campeonatos, Classificacoes, Times])
class CampeonatoDao extends DatabaseAccessor<AppDatabase> with _$CampeonatoDaoMixin {
  CampeonatoDao(super.db);

  Future<List<Campeonato>> obterTodosCampeonatos() => select(campeonatos).get();

  Future<Campeonato?> obterCampeonatoPorId(int id) =>
      (select(campeonatos)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  // --- Tabela de Classificação ---
  /// Retorna a classificação ordenada por pontos, vitórias e saldo de gols
  Future<List<ClassificacaoComDetalhes>> obterClassificacao(int campeonatoId) async {
    // Calculando o saldo de gols diretamente na query para ordenação
    final saldoDeGols = classificacoes.golsPro - classificacoes.golsContra;

    final query = select(classificacoes).join([
      innerJoin(times, times.id.equalsExp(classificacoes.timeId)),
    ])..where(classificacoes.campeonatoId.equals(campeonatoId))
      ..orderBy([
        OrderingTerm.desc(classificacoes.pontos),
        OrderingTerm.desc(classificacoes.vitorias),
        OrderingTerm.desc(saldoDeGols),
      ]);

    final rows = await query.get();

    return rows.map((row) {
      return ClassificacaoComDetalhes(
        classificacao: row.readTable(classificacoes),
        time: row.readTable(times),
      );
    }).toList();
  }

  // --- Operações CRUD ---
  Future<int> criarCampeonato(CampeonatosCompanion entity) => into(campeonatos).insert(entity);
  Future<bool> atualizarCampeonato(CampeonatosCompanion entity) => update(campeonatos).replace(entity);
  Future<int> deletarCampeonato(int id) => (delete(campeonatos)..where((tbl) => tbl.id.equals(id))).go();

  Future<int> inserirClassificacao(ClassificacoesCompanion entity) => into(classificacoes).insert(entity);
  Future<bool> atualizarClassificacao(ClassificacoesCompanion entity) => update(classificacoes).replace(entity);
}