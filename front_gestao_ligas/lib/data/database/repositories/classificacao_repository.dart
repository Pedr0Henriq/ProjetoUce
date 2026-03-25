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

  Future<List<domain.Classificacao>> buscarPorCampeonato(int campeonatoId) async {
    try {
      final response = await api.get('/campeonatos/$campeonatoId/classificacao');
      final list = response as List;
      final classificacaoApi = list.map((e) => domain.Classificacao.fromJson(e)).toList();

      for (var linha in classificacaoApi) {
        await dao.atualizarClassificacao(_domainToCompanion(linha));
      }

      final dadosDrift = await dao.obterClassificacao(campeonatoId);
      return dadosDrift.map(_mapClassificacaoToDomain).toList();

    } catch (e) {
      final dadosDrift = await dao.obterClassificacao(campeonatoId);
      return dadosDrift.map(_mapClassificacaoToDomain).toList();
    }
  }

  Future<List<Map<String, dynamic>>> artilharia(int campeonatoId) async {
    try {
      final response = await api.get('/campeonatos/$campeonatoId/artilharia');
      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      return []; 
    }
  }

  Future<List<Map<String, dynamic>>> assistencias(int campeonatoId) async {
    try {
      final response = await api.get('/campeonatos/$campeonatoId/assistencias');
      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }
}