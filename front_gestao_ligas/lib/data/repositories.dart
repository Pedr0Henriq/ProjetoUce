import '../models/models.dart';
import 'api_client.dart';

/// Repositório de autenticação (RF 01, RF 02, RF 11, RF 12)
class AuthRepository {
  final ApiClient _api;

  AuthRepository(this._api);

  Future<Map<String, dynamic>> login(String email, String senha) async {
    final response = await _api.post('/auth/login', {
      'email': email,
      'senha': senha,
    });
    return response as Map<String, dynamic>;
  }

  Future<void> logout() async {
    try {
      await _api.post('/auth/logout', {});
    } catch (_) {
      // Mesmo com erro na API, limpar token local
    }
    await _api.clearToken();
  }

  Future<void> recuperarSenha(String email) async {
    await _api.post('/auth/recuperar-senha', {'email': email});
  }

  Future<Usuario> getPerfil() async {
    final response = await _api.get('/auth/perfil');
    return Usuario.fromJson(response as Map<String, dynamic>);
  }

  Future<void> atualizarPerfil(Map<String, dynamic> dados) async {
    await _api.put('/auth/perfil', dados);
  }
}

/// Repositório de campeonatos (RF 03, RF 14, RF 15)
class CampeonatoRepository {
  final ApiClient _api;

  CampeonatoRepository(this._api);

  Future<List<Campeonato>> listar({String? busca}) async {
    final query = busca != null && busca.isNotEmpty ? '?busca=$busca' : '';
    final response = await _api.get('/campeonatos$query');
    final list = response as List;
    return list.map((e) => Campeonato.fromJson(e)).toList();
  }

  Future<Campeonato> buscarPorId(int id) async {
    final response = await _api.get('/campeonatos/$id');
    return Campeonato.fromJson(response as Map<String, dynamic>);
  }

  Future<Campeonato> criar(Map<String, dynamic> dados) async {
    final response = await _api.post('/campeonatos', dados);
    return Campeonato.fromJson(response as Map<String, dynamic>);
  }

  Future<Campeonato> editar(int id, Map<String, dynamic> dados) async {
    final response = await _api.put('/campeonatos/$id', dados);
    return Campeonato.fromJson(response as Map<String, dynamic>);
  }

  Future<void> excluir(int id) async {
    await _api.delete('/campeonatos/$id');
  }

  Future<void> encerrar(int id) async {
    await _api.post('/campeonatos/$id/encerrar', {});
  }
}

/// Repositório de times (RF 05)
class TimeRepository {
  final ApiClient _api;

  TimeRepository(this._api);

  Future<List<Time>> listarPorCampeonato(int campeonatoId) async {
    final response = await _api.get('/campeonatos/$campeonatoId/times');
    final list = response as List;
    return list.map((e) => Time.fromJson(e)).toList();
  }

  Future<Time> buscarPorId(int id) async {
    final response = await _api.get('/times/$id');
    return Time.fromJson(response as Map<String, dynamic>);
  }

  Future<Time> criar(Map<String, dynamic> dados) async {
    final response = await _api.post('/times', dados);
    return Time.fromJson(response as Map<String, dynamic>);
  }

  Future<Time> editar(int id, Map<String, dynamic> dados) async {
    final response = await _api.put('/times/$id', dados);
    return Time.fromJson(response as Map<String, dynamic>);
  }

  Future<void> excluir(int id) async {
    await _api.delete('/times/$id');
  }
}

/// Repositório de jogadores (RF 06)
class JogadorRepository {
  final ApiClient _api;

  JogadorRepository(this._api);

  Future<List<Jogador>> listarPorTime(int timeId) async {
    final response = await _api.get('/times/$timeId/jogadores');
    final list = response as List;
    return list.map((e) => Jogador.fromJson(e)).toList();
  }

  Future<Jogador> criar(Map<String, dynamic> dados) async {
    final response = await _api.post('/jogadores', dados);
    return Jogador.fromJson(response as Map<String, dynamic>);
  }

  Future<Jogador> editar(int id, Map<String, dynamic> dados) async {
    final response = await _api.put('/jogadores/$id', dados);
    return Jogador.fromJson(response as Map<String, dynamic>);
  }

  Future<void> excluir(int id) async {
    await _api.delete('/jogadores/$id');
  }
}

/// Repositório de partidas (RF 07, RF 08)
class PartidaRepository {
  final ApiClient _api;

  PartidaRepository(this._api);

  Future<List<Partida>> listarPorCampeonato(int campeonatoId) async {
    final response = await _api.get('/campeonatos/$campeonatoId/partidas');
    final list = response as List;
    return list.map((e) => Partida.fromJson(e)).toList();
  }

  Future<Partida> buscarPorId(int id) async {
    final response = await _api.get('/partidas/$id');
    return Partida.fromJson(response as Map<String, dynamic>);
  }

  Future<void> gerarCalendario(int campeonatoId) async {
    await _api.post('/campeonatos/$campeonatoId/gerar-calendario', {});
  }

  Future<Partida> criar(Map<String, dynamic> dados) async {
    final response = await _api.post('/partidas', dados);
    return Partida.fromJson(response as Map<String, dynamic>);
  }

  Future<Partida> editar(int id, Map<String, dynamic> dados) async {
    final response = await _api.put('/partidas/$id', dados);
    return Partida.fromJson(response as Map<String, dynamic>);
  }

  Future<void> excluir(int id) async {
    await _api.delete('/partidas/$id');
  }

  /// Registrar resultado e eventos (RF 04)
  Future<void> registrarResultado(
    int partidaId,
    Map<String, dynamic> resultado,
  ) async {
    await _api.post('/partidas/$partidaId/resultado', resultado);
  }

  /// Buscar eventos de uma partida (RF 16 — Súmula Eletrônica)
  Future<List<EventoPartida>> listarEventos(int partidaId) async {
    final response = await _api.get('/partidas/$partidaId/eventos');
    final list = response as List;
    return list.map((e) => EventoPartida.fromJson(e)).toList();
  }
}

/// Repositório de classificação e estatísticas (RF 09, RF 10)
class ClassificacaoRepository {
  final ApiClient _api;

  ClassificacaoRepository(this._api);

  Future<List<Classificacao>> buscarPorCampeonato(int campeonatoId) async {
    final response = await _api.get('/campeonatos/$campeonatoId/classificacao');
    final list = response as List;
    return list.map((e) => Classificacao.fromJson(e)).toList();
  }

  /// Artilharia (gols por jogador)
  Future<List<Map<String, dynamic>>> artilharia(int campeonatoId) async {
    final response = await _api.get('/campeonatos/$campeonatoId/artilharia');
    return (response as List).cast<Map<String, dynamic>>();
  }

  /// Assistências por jogador
  Future<List<Map<String, dynamic>>> assistencias(int campeonatoId) async {
    final response = await _api.get('/campeonatos/$campeonatoId/assistencias');
    return (response as List).cast<Map<String, dynamic>>();
  }
}
