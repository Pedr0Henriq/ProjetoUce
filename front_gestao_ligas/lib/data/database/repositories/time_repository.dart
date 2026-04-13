import 'package:front_gestao_ligas/data/api_client.dart';
import 'package:front_gestao_ligas/data/database/daos/time_dao.dart';
import 'package:front_gestao_ligas/data/database/database.dart' as db;
import 'package:front_gestao_ligas/models/time.dart' as domain_time;
import 'package:front_gestao_ligas/models/jogador.dart' as domain_jogador;
import 'package:drift/drift.dart' as drift;

/// Repositório de times (RF 05) e Repositório de jogadores (RF 06)
class TimeRepository {
  final TimeDao dao;
  final ApiClient api;

  TimeRepository({required this.dao, required this.api});

  domain_time.Time _mapTimeToDomain(db.Time data) {
    return domain_time.Time(
      id: data.id,
      nome: data.nome,
      localidade: data.localidade,
      escudoUrl: data.escudoUrl,
      campeonatoId: data.campeonatoId,
    );
  }

  domain_jogador.Jogador _mapJogadorToDomain(db.Jogadore data) {
    return domain_jogador.Jogador(
      id: data.id,
      nome: data.nome,
      numero: data.numero,
      posicao: data.posicao,
      timeId: data.timeId,
    );
  }

  db.TimesCompanion _timeToCompanion(domain_time.Time time) {
    return db.TimesCompanion(
      id: drift.Value(time.id),
      nome: drift.Value(time.nome),
      localidade: drift.Value(time.localidade),
      escudoUrl: drift.Value(time.escudoUrl),
      campeonatoId: drift.Value(time.campeonatoId),
    );
  }

  db.JogadoresCompanion _jogadorToCompanion(domain_jogador.Jogador jogador) {
    return db.JogadoresCompanion(
      id: drift.Value(jogador.id),
      nome: drift.Value(jogador.nome),
      numero: drift.Value(jogador.numero),
      posicao: drift.Value(jogador.posicao),
      timeId: drift.Value(jogador.timeId),
    );
  }

  Future<List<domain_time.Time>> buscarTimesPorCampeonato(
    int campeonatoId,
  ) async {
    try {
      final response = await api.get('/campeonatos/$campeonatoId/times');
      final list = response as List;
      final timesApi = list.map((e) => domain_time.Time.fromJson(e)).toList();

      for (var time in timesApi) {
        final companion = _timeToCompanion(time);
        final updated = await dao.atualizarTime(companion);
        if (!updated) {
          await dao.criarTime(companion);
        }
      }

      return timesApi;
    } catch (e) {
      final dadosDrift = await dao.obterTimesPorCampeonato(campeonatoId);
      return dadosDrift.map(_mapTimeToDomain).toList();
    }
  }

  Future<domain_time.Time?> buscarPorId(int id) async {
    try {
      final response = await api.get('/times/$id');
      final timeApi = domain_time.Time.fromJson(
        response as Map<String, dynamic>,
      );

      final companion = _timeToCompanion(timeApi);
      final updated = await dao.atualizarTime(companion);
      if (!updated) {
        await dao.criarTime(companion);
      }
      return timeApi;
    } catch (e) {
      final dadoDrift = await dao.obterTimePorId(id);
      return dadoDrift != null ? _mapTimeToDomain(dadoDrift) : null;
    }
  }

  Future<domain_time.Time> criar(int campeonatoId, Map<String, dynamic> dados) async {
    final response = await api.post('/campeonatos/$campeonatoId/times', dados);
    final novoTime = domain_time.Time.fromJson(
      response as Map<String, dynamic>,
    );

    final companion = _timeToCompanion(novoTime);
    final updated = await dao.atualizarTime(companion);
    if (!updated) {
      await dao.criarTime(companion);
    }
    return novoTime;
  }

  Future<domain_time.Time> editar(int id, Map<String, dynamic> dados) async {
    final response = await api.put('/times/$id', dados);
    final timeAtualizado = domain_time.Time.fromJson(
      response as Map<String, dynamic>,
    );

    final companion = _timeToCompanion(timeAtualizado);
    final updated = await dao.atualizarTime(companion);
    if (!updated) {
      await dao.criarTime(companion);
    }
    return timeAtualizado;
  }

  Future<void> excluir(int id) async {
    await api.delete('/times/$id');
    await dao.deletarTime(id);
  }

  Future<List<domain_jogador.Jogador>> listarJogadores(int timeId) async {
    try {
      final response = await api.get('/times/$timeId/jogadores');
      final list = response as List;
      final jogadoresApi = list
          .map((e) => domain_jogador.Jogador.fromJson(e))
          .toList();

      for (var jogador in jogadoresApi) {
        final companion = _jogadorToCompanion(jogador);
        final updated = await dao.atualizarJogador(companion);
        if (!updated) {
          await dao.adicionarJogador(companion);
        }
      }

      return jogadoresApi;
    } catch (e) {
      final dadosDrift = await dao.obterJogadoresPorTime(timeId);
      return dadosDrift.map(_mapJogadorToDomain).toList();
    }
  }

  Future<domain_jogador.Jogador> adicionarJogador(int timeId, Map<String, dynamic> dados) async {
    final response = await api.post('/times/$timeId/jogadores', dados);
    final novoJogador = domain_jogador.Jogador.fromJson(response as Map<String, dynamic>);
    
    final companion = _jogadorToCompanion(novoJogador);
    final updated = await dao.atualizarJogador(companion);
    if (!updated) {
      await dao.adicionarJogador(companion);
    }
    return novoJogador;
  }

  Future<domain_jogador.Jogador> editarJogador(int jogadorId, Map<String, dynamic> dados) async {
    final response = await api.put('/jogadores/$jogadorId', dados);
    final novoJogador = domain_jogador.Jogador.fromJson(response as Map<String, dynamic>);
    
    final companion = _jogadorToCompanion(novoJogador);
    final updated = await dao.atualizarJogador(companion);
    if (!updated) {
      await dao.adicionarJogador(companion);
    }

    return novoJogador;
  }

  Future<void> removerJogador(int jogadorId) async {
    await api.delete('/jogadores/$jogadorId');
    await dao.removerJogador(jogadorId);
  }
}
