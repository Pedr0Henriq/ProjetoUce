import 'package:drift/drift.dart';
import 'package:front_gestao_ligas/data/api_client.dart';
import 'package:front_gestao_ligas/data/database/daos/campeonato_dao.dart';
import 'package:front_gestao_ligas/models/campeonato.dart';
import 'package:front_gestao_ligas/data/database/database.dart' as db;
import 'package:front_gestao_ligas/models/models.dart' as domain;

/// Repositório de campeonatos (RF 03, RF 14, RF 15)
class CampeonatoRepository {
  final CampeonatoDao dao;
  final ApiClient api;

  CampeonatoRepository({required this.dao, required this.api});

  Future<void> _upsertCampeonato(db.CampeonatosCompanion companion) async {
    final updated = await dao.atualizarCampeonato(companion);
    if (!updated) {
      await dao.criarCampeonato(companion);
    }
  }

  domain.Campeonato _mapCampeonatoToDomain(db.Campeonato data) {
    final tipo = data.tipo.toLowerCase();
    return domain.Campeonato(
      id: data.id,
      nome: data.nome,
      modalidade: data.modalidade,
      tipo: (tipo == 'ponto_corrido' || tipo == 'pontos_corridos')
          ? domain.TipoCampeonato.pontoCorrido 
          : domain.TipoCampeonato.eliminatoria,
      numEquipes: data.numEquipes,
      dataInicio: data.dataInicio,
      status: StatusCampeonato.to(data.status),
      criadoPor: data.criadoPor,
    );
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

  db.CampeonatosCompanion _domainToCompanion(domain.Campeonato campeonato) {
    return db.CampeonatosCompanion(
      id: Value(campeonato.id),
      nome: Value(campeonato.nome),
      modalidade: Value(campeonato.modalidade),
      tipo: Value(campeonato.tipo == domain.TipoCampeonato.pontoCorrido ? 'PONTOS_CORRIDOS' : 'ELIMINATORIA'),
      numEquipes: Value(campeonato.numEquipes),
      dataInicio: Value(campeonato.dataInicio),
      status: Value(StatusCampeonato.of(campeonato.status)),
      criadoPor: Value(campeonato.criadoPor),
    );
  }

  Future<List<domain.Campeonato>> listar({String? busca}) async {
    try {
      final query = busca != null && busca.isNotEmpty ? '?busca=$busca' : '';
      final response = await api.get('/campeonatos$query');
      final list = response as List;
      final campeonatosApi = list.map((e) => domain.Campeonato.fromJson(e)).toList();
      for (var camp in campeonatosApi) {
        await _upsertCampeonato(_domainToCompanion(camp));
      }

      return campeonatosApi;
    } catch (e) {
      final dadosDrift = await dao.obterTodosCampeonatos();
      return dadosDrift.map(_mapCampeonatoToDomain).toList();
    }
  }

  Future<domain.Campeonato> buscarPorId(int id) async {
    try {
      final response = await api.get('/campeonatos/$id');
      final campeonatoApi = domain.Campeonato.fromJson(response as Map<String, dynamic>);
      
      await _upsertCampeonato(_domainToCompanion(campeonatoApi));
      return campeonatoApi;
    } catch (e) {
      final dadoDrift = await dao.obterCampeonatoPorId(id);
      if (dadoDrift != null) {
        return _mapCampeonatoToDomain(dadoDrift);
      }
      rethrow;
    }
  }

  Future<domain.Campeonato> criar(Map<String, dynamic> dados) async {
    final response = await api.post('/campeonatos', dados);
    final novoCampeonato = domain.Campeonato.fromJson(response as Map<String, dynamic>);
    
    await _upsertCampeonato(_domainToCompanion(novoCampeonato));
    
    return novoCampeonato;
  }

  Future<domain.Campeonato> editar(int id, Map<String, dynamic> dados) async {
    final response = await api.put('/campeonatos/$id', dados);
    final campeonatoAtualizado = domain.Campeonato.fromJson(response as Map<String, dynamic>);
    
    await _upsertCampeonato(_domainToCompanion(campeonatoAtualizado));
    return campeonatoAtualizado;
  }

  Future<void> excluir(int id) async {
    await api.delete('/campeonatos/$id');
    await dao.deletarCampeonato(id);
  }

  Future<void> encerrar(int id, int campeaoTimeId) async {
    await api.post('/campeonatos/$id/encerrar', {'campeao_time_id': campeaoTimeId});
    
    final campLocal = await dao.obterCampeonatoPorId(id);
    if (campLocal != null) {
      await dao.atualizarCampeonato(campLocal.toCompanion(true).copyWith(status: const Value('encerrado')));
    }
  }

  Future<List<domain.Classificacao>> buscarTabelaDeClassificacao(int campeonatoId) async {
    final dadosDrift = await dao.obterClassificacao(campeonatoId);
    return dadosDrift.map(_mapClassificacaoToDomain).toList();
  }
}