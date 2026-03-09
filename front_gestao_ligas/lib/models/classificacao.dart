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
    return Classificacao(
      id: json['id'] as int,
      campeonatoId: json['campeonato_id'] as int,
      timeId: json['time_id'] as int,
      pontos: json['pontos'] as int,
      jogos: json['jogos'] as int,
      vitorias: json['vitorias'] as int,
      empates: json['empates'] as int,
      derrotas: json['derrotas'] as int,
      golsPro: json['gols_pro'] as int,
      golsContra: json['gols_contra'] as int,
      nomeTime: json['nome_time'] as String?,
      escudoUrl: json['escudo_url'] as String?,
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
