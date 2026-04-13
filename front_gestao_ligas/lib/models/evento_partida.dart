enum TipoEvento { gol, assistencia, cartaoAmarelo, cartaoVermelho }

class EventoPartida {
  final int id;
  final int partidaId;
  final TipoEvento tipo;
  final int? minuto;
  final int jogadorId;
  final int timeId;

  // Campos opcionais preenchidos via join
  final String? nomeJogador;
  final String? nomeTime;

  const EventoPartida({
    required this.id,
    required this.partidaId,
    required this.tipo,
    this.minuto,
    required this.jogadorId,
    required this.timeId,
    this.nomeJogador,
    this.nomeTime,
  });

  factory EventoPartida.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic value, {int fallback = 0}) {
      if (value is int) return value;
      return int.tryParse(value?.toString() ?? '') ?? fallback;
    }

    TipoEvento parseTipo(dynamic tipoValue) {
      final s = (tipoValue ?? '').toString().toLowerCase();
      switch (s) {
        case 'gol':
          return TipoEvento.gol;
        case 'assistencia':
          return TipoEvento.assistencia;
        case 'cartao_amarelo':
          return TipoEvento.cartaoAmarelo;
        case 'cartao_vermelho':
          return TipoEvento.cartaoVermelho;
        default:
          return TipoEvento.gol;
      }
    }

    final jogadorMap = json['jogador'] as Map<String, dynamic>?;
    final timeMap = json['time'] as Map<String, dynamic>?;

    return EventoPartida(
      id: parseInt(json['id']),
      partidaId: parseInt(json['partida_id']),
      tipo: parseTipo(json['tipo']),
      minuto: json['minuto'] as int?,
      jogadorId: parseInt(json['jogador_id'] ?? jogadorMap?['id']),
      timeId: parseInt(json['time_id'] ?? timeMap?['id']),
      nomeJogador:
          (json['nome_jogador'] as String?) ?? (jogadorMap?['nome'] as String?),
      nomeTime: (json['nome_time'] as String?) ?? (timeMap?['nome'] as String?),
    );
  }

  Map<String, dynamic> toJson() {
    String tipoStr;
    switch (tipo) {
      case TipoEvento.gol:
        tipoStr = 'gol';
        break;
      case TipoEvento.assistencia:
        tipoStr = 'assistencia';
        break;
      case TipoEvento.cartaoAmarelo:
        tipoStr = 'cartao_amarelo';
        break;
      case TipoEvento.cartaoVermelho:
        tipoStr = 'cartao_vermelho';
        break;
    }

    return {
      'id': id,
      'partida_id': partidaId,
      'tipo': tipoStr,
      'minuto': minuto,
      'jogador_id': jogadorId,
      'time_id': timeId,
    };
  }

  String get tipoFormatado {
    switch (tipo) {
      case TipoEvento.gol:
        return '⚽ Gol';
      case TipoEvento.assistencia:
        return '👟 Assistência';
      case TipoEvento.cartaoAmarelo:
        return '🟨 Cartão Amarelo';
      case TipoEvento.cartaoVermelho:
        return '🟥 Cartão Vermelho';
    }
  }
}
