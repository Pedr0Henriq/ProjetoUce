import 'package:drift/drift.dart' as drift;
import 'package:flutter/cupertino.dart';
import 'package:front_gestao_ligas/data/api_client.dart';
import 'package:front_gestao_ligas/data/database/daos/partida_dao.dart';
import 'package:front_gestao_ligas/data/database/database.dart' as db;
import 'package:front_gestao_ligas/data/database/repositories/campeonato_repository.dart';
import 'package:front_gestao_ligas/models/models.dart';
import 'package:front_gestao_ligas/models/partida.dart' as domain;
import 'package:front_gestao_ligas/models/evento_partida.dart' as domain_evento;

/// Repositório de partidas (RF 07, RF 08) e Registrar resultado e eventos (RF 04)
class PartidaRepository {
  final PartidaDao dao;
  final CampeonatoRepository campeonatoRepository;
  final ApiClient api;

  PartidaRepository({required this.dao, required this.campeonatoRepository, required this.api});

  domain.Partida _mapPartidaToDomain(PartidaComDetalhes detalhe) {
    domain.StatusPartida statusDomain;
    switch (detalhe.partida.status) {
      case 'em_andamento':
        statusDomain = domain.StatusPartida.emAndamento;
        break;
      case 'finalizada':
        statusDomain = domain.StatusPartida.finalizada;
        break;
      case 'agendada':
      default:
        statusDomain = domain.StatusPartida.agendada;
        break;
    }

    return domain.Partida(
      id: detalhe.partida.id,
      campeonatoId: detalhe.partida.campeonatoId,
      rodada: detalhe.partida.rodada,
      timeMandanteId: detalhe.partida.timeMandanteId,
      timeVisitanteId: detalhe.partida.timeVisitanteId,
      data: detalhe.partida.data,
      horario: detalhe.partida.horario,
      local: detalhe.partida.local,
      status: statusDomain,
      nomeMandante: detalhe.mandante.nome,
      escudoMandante: detalhe.mandante.escudoUrl,
      nomeVisitante: detalhe.visitante.nome,
      escudoVisitante: detalhe.visitante.escudoUrl,
      golsMandante: detalhe.resultado?.golsMandante,
      golsVisitante: detalhe.resultado?.golsVisitante,
    );
  }

  db.PartidasCompanion _domainToCompanion(domain.Partida partida) {
    String statusStr;
    switch (partida.status) {
      case domain.StatusPartida.emAndamento:
        statusStr = 'em_andamento';
        break;
      case domain.StatusPartida.finalizada:
        statusStr = 'finalizada';
        break;
      case domain.StatusPartida.agendada:
        statusStr = 'agendada';
        break;
    }

    return db.PartidasCompanion(
      id: drift.Value(partida.id),
      campeonatoId: drift.Value(partida.campeonatoId),
      rodada: drift.Value(partida.rodada),
      timeMandanteId: drift.Value(partida.timeMandanteId),
      timeVisitanteId: drift.Value(partida.timeVisitanteId),
      status: drift.Value(statusStr),
      data: drift.Value(partida.data),
      horario: drift.Value(partida.horario),
      local: drift.Value(partida.local),
    );
  }

  Future<List<domain.Partida>> listarPorCampeonato(int campeonatoId) async {
    try {
      final response = await api.get('/campeonatos/$campeonatoId/partidas');
      final list = response as List;
      final partidasApi = list.map((e) => domain.Partida.fromJson(e)).toList();

      for (var partida in partidasApi) {
        await dao.atualizarPartida(_domainToCompanion(partida));
      }

      final dadosDrift = await dao.obterPartidasPorCampeonato(campeonatoId);
      return dadosDrift.map(_mapPartidaToDomain).toList();
    } catch (e) {
      final dadosDrift = await dao.obterPartidasPorCampeonato(campeonatoId);
      return dadosDrift.map(_mapPartidaToDomain).toList();
    }
  }

  Future<domain.Partida?> buscarPorId(int id) async {
    try {
      final response = await api.get('/partidas/$id');
      final partidaApi = domain.Partida.fromJson(
        response as Map<String, dynamic>,
      );

      await dao.atualizarPartida(_domainToCompanion(partidaApi));

      final detalhe = await dao.obterPartidaPorId(id);
      return detalhe != null ? _mapPartidaToDomain(detalhe) : null;
    } catch (e) {
      final detalhe = await dao.obterPartidaPorId(id);
      return detalhe != null ? _mapPartidaToDomain(detalhe) : null;
    }
  }

  Future<void> gerarCalendario(int campeonatoId) async {
    try {
    final campeonato = await campeonatoRepository.buscarPorId(campeonatoId);
    debugPrint('${TipoCampeonato.of(campeonato.tipo.label).toUpperCase()}');
    final response = await api.post('/campeonatos/$campeonatoId/gerar-calendario', {
      'tipo_geracao': TipoCampeonato.of(campeonato.tipo.label).toUpperCase(),
      'data_primeira_rodada': campeonato.dataInicio.toIso8601String().split('T')[0]
    });

    debugPrint('Resposta: $response');
    } catch (e,stack) {
    debugPrint(e.toString());
     debugPrintStack(stackTrace: stack);
    }
  }

  Future<domain.Partida> criar(Map<String, dynamic> dados) async {
    final response = await api.post('/partidas', dados);
    final novaPartida = domain.Partida.fromJson(
      response as Map<String, dynamic>,
    );

    await dao.atualizarPartida(_domainToCompanion(novaPartida));
    return novaPartida;
  }

  Future<domain.Partida> editar(int id, Map<String, dynamic> dados) async {
    final response = await api.put('/partidas/$id', dados);
    final partidaAtualizada = domain.Partida.fromJson(
      response as Map<String, dynamic>,
    );

    await dao.atualizarPartida(_domainToCompanion(partidaAtualizada));
    return partidaAtualizada;
  }

  Future<void> excluir(int id) async {
    await api.delete('/partidas/$id');
    await dao.deletarPartida(id);
  }

  Future<void> registrarResultado(
    int partidaId,
    Map<String, dynamic> resultadoMap,
  ) async {
    await api.post('/partidas/$partidaId/resultado', resultadoMap);

    final companion = db.ResultadosCompanion.insert(
      partidaId: partidaId,
      golsMandante: resultadoMap['gols_mandante'] as int,
      golsVisitante: resultadoMap['gols_visitante'] as int,
      registradoPor: resultadoMap['registrado_por'] as int,
      registradoEm: DateTime.parse(
        resultadoMap['registrado_em'] ?? DateTime.now().toIso8601String(),
      ),
    );

    await dao.registrarResultado(companion);

    final partidaAtual = await dao.obterPartidaPorId(partidaId);
    if (partidaAtual != null) {
      await dao.atualizarPartida(
        partidaAtual.partida
            .toCompanion(true)
            .copyWith(status: const drift.Value('finalizada')),
      );
    }
  }

  Future<List<domain_evento.EventoPartida>> listarEventos(int partidaId) async {
    final response = await api.get('/partidas/$partidaId/eventos');
    final list = response as List;
    return list.map((e) => domain_evento.EventoPartida.fromJson(e)).toList();
  }
}
