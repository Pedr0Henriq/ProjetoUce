import 'package:front_gestao_ligas/data/api_client.dart';
import 'package:front_gestao_ligas/data/database/daos/campeonato_dao.dart';
import 'package:front_gestao_ligas/data/database/database.dart' as db;
import 'package:front_gestao_ligas/models/classificacao.dart' as domain;
import 'package:drift/drift.dart' as drift;

/// Repositório de classificação e estatísticas (RF 09, RF 10)
class ClassificacaoRepository {
  final ApiClient api;
  final CampeonatoDao dao;

  ClassificacaoRepository({required this.api, required this.dao});

  int _parseInt(dynamic value, {int fallback = 0}) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? fallback;
  }


  domain.Classificacao _mapClassificacaoToDomain(ClassificacaoComDetalhes detalhe) {
    return domain.Classificacao(
      id: detalhe.classificacao.id,
      campeonatoId: detalhe.classificacao.campeonatoId,
      timeId: detalhe.classificacao.timeId,
      pontos: detalhe.classificacao.pontos,
      jogos: detalhe.classificacao.jogos,
      vitorias: detalhe.classificacao.vitorias,
      empates: detalhe.classificacao.empates,
      derrotas: detalhe.classificacao.derrotas,
      golsPro: detalhe.classificacao.golsPro,
      golsContra: detalhe.classificacao.golsContra,
      nomeTime: detalhe.time.nome,
      escudoUrl: detalhe.time.escudoUrl,
    );
  }

  db.ClassificacoesCompanion _domainToCompanion(domain.Classificacao classificacao) {
    return db.ClassificacoesCompanion(
      id: drift.Value(classificacao.id),
      campeonatoId: drift.Value(classificacao.campeonatoId),
      timeId: drift.Value(classificacao.timeId),
      pontos: drift.Value(classificacao.pontos),
      jogos: drift.Value(classificacao.jogos),
      vitorias: drift.Value(classificacao.vitorias),
      empates: drift.Value(classificacao.empates),
      derrotas: drift.Value(classificacao.derrotas),
      golsPro: drift.Value(classificacao.golsPro),
      golsContra: drift.Value(classificacao.golsContra),
    );
  }

  domain.Classificacao _mapApiLineToDomain(
    Map<String, dynamic> json,
    int campeonatoId,
  ) {
    final time = json['time'] as Map<String, dynamic>?;
    final timeId = _parseInt(json['time_id'] ?? time?['id']);
    final syntheticId = _parseInt(
      json['id'],
      fallback: campeonatoId * 100000 + timeId,
    );

    return domain.Classificacao(
      id: syntheticId,
      campeonatoId: _parseInt(json['campeonato_id'], fallback: campeonatoId),
      timeId: timeId,
      pontos: _parseInt(json['pontos']),
      jogos: _parseInt(json['jogos']),
      vitorias: _parseInt(json['vitorias']),
      empates: _parseInt(json['empates']),
      derrotas: _parseInt(json['derrotas']),
      golsPro: _parseInt(json['gols_pro']),
      golsContra: _parseInt(json['gols_contra']),
      nomeTime: (json['nome_time'] as String?) ?? (time?['nome'] as String?),
      escudoUrl:
          (json['escudo_url'] as String?) ?? (time?['escudo_url'] as String?),
    );
  }

  Future<List<domain.Classificacao>> buscarPorCampeonato(int campeonatoId) async {
    try {
      final response = await api.get('/campeonatos/$campeonatoId/classificacao');
      final list = response as List;
      final classificacaoApi = list
          .map((e) => _mapApiLineToDomain(e as Map<String, dynamic>, campeonatoId))
          .toList();

      for (var linha in classificacaoApi) {
        final companion = _domainToCompanion(linha);
        final updated = await dao.atualizarClassificacao(companion);
        if (!updated) {
          await dao.inserirClassificacao(companion);
        }
      }

      return classificacaoApi;

    } catch (e) {
      final dadosDrift = await dao.obterClassificacao(campeonatoId);
      return dadosDrift.map(_mapClassificacaoToDomain).toList();
    }
  }

  Future<List<Map<String, dynamic>>> artilhariaEAssistencia(int campeonatoId) async {
    try {
      final response = await api.get('/campeonatos/$campeonatoId/artilharia');
      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      return []; 
    }
  }
}