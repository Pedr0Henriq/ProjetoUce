class Resultado {
  final int id;
  final int partidaId;
  final int golsMandante;
  final int golsVisitante;
  final int registradoPor;
  final DateTime registradoEm;

  const Resultado({
    required this.id,
    required this.partidaId,
    required this.golsMandante,
    required this.golsVisitante,
    required this.registradoPor,
    required this.registradoEm,
  });

  factory Resultado.fromJson(Map<String, dynamic> json) {
    return Resultado(
      id: json['id'] as int,
      partidaId: json['partida_id'] as int,
      golsMandante: json['gols_mandante'] as int,
      golsVisitante: json['gols_visitante'] as int,
      registradoPor: json['registrado_por'] as int,
      registradoEm: DateTime.parse(json['registrado_em'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'partida_id': partidaId,
      'gols_mandante': golsMandante,
      'gols_visitante': golsVisitante,
      'registrado_por': registradoPor,
      'registrado_em': registradoEm.toIso8601String(),
    };
  }
}
