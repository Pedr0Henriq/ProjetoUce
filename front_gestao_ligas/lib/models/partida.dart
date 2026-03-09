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
    StatusPartida parseStatus(String s) {
      switch (s) {
        case 'em_andamento':
          return StatusPartida.emAndamento;
        case 'finalizada':
          return StatusPartida.finalizada;
        default:
          return StatusPartida.agendada;
      }
    }

    return Partida(
      id: json['id'] as int,
      campeonatoId: json['campeonato_id'] as int,
      rodada: json['rodada'] as int,
      timeMandanteId: json['time_mandante_id'] as int,
      timeVisitanteId: json['time_visitante_id'] as int,
      data: json['data'] != null ? DateTime.parse(json['data'] as String) : null,
      horario: json['horario'] as String?,
      local: json['local'] as String?,
      status: parseStatus(json['status'] as String),
      nomeMandante: json['nome_mandante'] as String?,
      nomeVisitante: json['nome_visitante'] as String?,
      escudoMandante: json['escudo_mandante'] as String?,
      escudoVisitante: json['escudo_visitante'] as String?,
      golsMandante: json['gols_mandante'] as int?,
      golsVisitante: json['gols_visitante'] as int?,
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
