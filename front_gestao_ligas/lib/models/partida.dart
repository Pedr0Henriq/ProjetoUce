enum StatusPartida { agendada, emAndamento, finalizada }

class Partida {
  final int id;
  final int campeonatoId;
  final int rodada;
  final int timeMandanteId;
  final int timeVisitanteId;
  final DateTime? data;
  final String? horario;
  final String? local;
  final StatusPartida status;

  // Campos opcionais preenchidos pela API com joins
  final String? nomeMandante;
  final String? nomeVisitante;
  final String? escudoMandante;
  final String? escudoVisitante;
  final int? golsMandante;
  final int? golsVisitante;

  const Partida({
    required this.id,
    required this.campeonatoId,
    required this.rodada,
    required this.timeMandanteId,
    required this.timeVisitanteId,
    this.data,
    this.horario,
    this.local,
    required this.status,
    this.nomeMandante,
    this.nomeVisitante,
    this.escudoMandante,
    this.escudoVisitante,
    this.golsMandante,
    this.golsVisitante,
  });

  factory Partida.fromJson(Map<String, dynamic> json) {
    int? parseNullableInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      return int.tryParse(value.toString());
    }

    int parseInt(dynamic value, {int fallback = 0}) {
      return parseNullableInt(value) ?? fallback;
    }

    StatusPartida parseStatus(dynamic statusValue) {
      final status = (statusValue ?? '').toString().toLowerCase();
      switch (status) {
        case 'em_andamento':
          return StatusPartida.emAndamento;
        case 'finalizada':
          return StatusPartida.finalizada;
        case 'agendada':
        default:
          return StatusPartida.agendada;
      }
    }

    final timeMandante = json['time_mandante'] as Map<String, dynamic>?;
    final timeVisitante = json['time_visitante'] as Map<String, dynamic>?;

    return Partida(
      id: parseInt(json['id']),
      campeonatoId: parseInt(json['campeonato_id']),
      rodada: parseInt(json['rodada']),
      timeMandanteId:
          parseInt(json['time_mandante_id'] ?? timeMandante?['id']),
      timeVisitanteId:
          parseInt(json['time_visitante_id'] ?? timeVisitante?['id']),
      data: json['data'] != null ? DateTime.parse(json['data'] as String) : null,
      horario: json['horario'] as String?,
      local: json['local'] as String?,
      status: parseStatus(json['status']),
      nomeMandante:
          (json['nome_mandante'] as String?) ?? (timeMandante?['nome'] as String?),
      nomeVisitante:
          (json['nome_visitante'] as String?) ?? (timeVisitante?['nome'] as String?),
      escudoMandante: (json['escudo_mandante'] as String?) ??
          (timeMandante?['escudo_url'] as String?),
      escudoVisitante: (json['escudo_visitante'] as String?) ??
          (timeVisitante?['escudo_url'] as String?),
      golsMandante:
          parseNullableInt(json['gols_mandante'] ?? json['placar_mandante']),
      golsVisitante:
          parseNullableInt(json['gols_visitante'] ?? json['placar_visitante']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'campeonato_id': campeonatoId,
      'rodada': rodada,
      'time_mandante_id': timeMandanteId,
      'time_visitante_id': timeVisitanteId,
      'data': data?.toIso8601String(),
      'horario': horario,
      'local': local,
      'status': status == StatusPartida.agendada
          ? 'agendada'
          : status == StatusPartida.emAndamento
              ? 'em_andamento'
              : 'finalizada',
    };
  }

  bool get isFinalizada => status == StatusPartida.finalizada;

  String get statusFormatado {
    switch (status) {
      case StatusPartida.agendada:
        return 'Agendada';
      case StatusPartida.emAndamento:
        return 'Em andamento';
      case StatusPartida.finalizada:
        return 'Finalizada';
    }
  }
}
