class Classificacao {
  final int id;
  final int campeonatoId;
  final int timeId;
  final int pontos;
  final int jogos;
  final int vitorias;
  final int empates;
  final int derrotas;
  final int golsPro;
  final int golsContra;

  // Campo opcional preenchido via join
  final String? nomeTime;
  final String? escudoUrl;

  const Classificacao({
    required this.id,
    required this.campeonatoId,
    required this.timeId,
    required this.pontos,
    required this.jogos,
    required this.vitorias,
    required this.empates,
    required this.derrotas,
    required this.golsPro,
    required this.golsContra,
    this.nomeTime,
    this.escudoUrl,
  });

  int get saldoGols => golsPro - golsContra;

  factory Classificacao.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic value, {int fallback = 0}) {
      if (value is int) return value;
      return int.tryParse(value?.toString() ?? '') ?? fallback;
    }

    final time = json['time'] as Map<String, dynamic>?;
    final timeId = parseInt(json['time_id'] ?? time?['id']);

    return Classificacao(
      id: parseInt(json['id'], fallback: timeId),
      campeonatoId: parseInt(json['campeonato_id']),
      timeId: timeId,
      pontos: parseInt(json['pontos']),
      jogos: parseInt(json['jogos']),
      vitorias: parseInt(json['vitorias']),
      empates: parseInt(json['empates']),
      derrotas: parseInt(json['derrotas']),
      golsPro: parseInt(json['gols_pro']),
      golsContra: parseInt(json['gols_contra']),
      nomeTime: (json['nome_time'] as String?) ?? (time?['nome'] as String?),
      escudoUrl:
          (json['escudo_url'] as String?) ?? (time?['escudo_url'] as String?),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'campeonato_id': campeonatoId,
      'time_id': timeId,
      'pontos': pontos,
      'jogos': jogos,
      'vitorias': vitorias,
      'empates': empates,
      'derrotas': derrotas,
      'gols_pro': golsPro,
      'gols_contra': golsContra,
    };
  }
}
