import 'package:drift/drift.dart';
import 'package:front_gestao_ligas/data/database/database.dart';
import 'package:front_gestao_ligas/data/database/tables/core_tables.dart';

part 'partida_dao.g.dart';

class PartidaComDetalhes {
  final Partida partida;
  final Time mandante;
  final Time visitante;
  final Resultado? resultado;

  PartidaComDetalhes({
    required this.partida,
    required this.mandante,
    required this.visitante,
    this.resultado,
  });
}

@DriftAccessor(tables: [Partidas, Times, Resultados, EventosPartidas])
class PartidaDao extends DatabaseAccessor<AppDatabase> with _$PartidaDaoMixin {
  PartidaDao(super.db);

  late final mandante = alias(times, 'mandante');
  late final visitante = alias(times, 'visitante');

  Future<List<PartidaComDetalhes>> obterPartidasPorCampeonato(int campeonatoId) async {
    final query = select(partidas).join([
      // Join para buscar os dados do time mandante
      innerJoin(mandante, mandante.id.equalsExp(partidas.timeMandanteId)),
      
      // Join para buscar os dados do time visitante
      innerJoin(visitante, visitante.id.equalsExp(partidas.timeVisitanteId)),
      
      // Left Join para buscar o resultado (se houver, caso contrário vem null)
      leftOuterJoin(resultados, resultados.partidaId.equalsExp(partidas.id)),
    ])..where(partidas.campeonatoId.equals(campeonatoId));

    final rows = await query.get();

    return rows.map((row) {
      return PartidaComDetalhes(
        partida: row.readTable(partidas),
        mandante: row.readTable(mandante),
        visitante: row.readTable(visitante),
        resultado: row.readTableOrNull(resultados),
      );
    }).toList();
  }

  /// Busca os detalhes de uma partida específica por ID
  Future<PartidaComDetalhes?> obterPartidaPorId(int partidaId) async {
    final query = select(partidas).join([
      innerJoin(mandante, mandante.id.equalsExp(partidas.timeMandanteId)),
      innerJoin(visitante, visitante.id.equalsExp(partidas.timeVisitanteId)),
      leftOuterJoin(resultados, resultados.partidaId.equalsExp(partidas.id)),
    ])..where(partidas.id.equals(partidaId));

    final row = await query.getSingleOrNull();
    if (row == null) return null;

    return PartidaComDetalhes(
      partida: row.readTable(partidas),
      mandante: row.readTable(mandante),
      visitante: row.readTable(visitante),
      resultado: row.readTableOrNull(resultados),
    );
  }

  Future<int> criarPartida(PartidasCompanion entity) => into(partidas).insert(entity);
  
  Future<bool> atualizarPartida(PartidasCompanion entity) => update(partidas).replace(entity);
  
  Future<int> deletarPartida(int id) => 
      (delete(partidas)..where((tbl) => tbl.id.equals(id))).go();

  Future<int> registrarResultado(ResultadosCompanion entity) => into(resultados).insert(entity);
}