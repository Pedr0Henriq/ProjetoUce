class Time {
  final int id;
  final String nome;
  final String localidade;
  final String? escudoUrl;
  final int campeonatoId;

  const Time({
    required this.id,
    required this.nome,
    required this.localidade,
    this.escudoUrl,
    required this.campeonatoId,
  });

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      id: json['id'] as int,
      nome: json['nome'] as String,
      localidade: json['localidade'] as String,
      escudoUrl: json['escudo_url'] as String?,
      campeonatoId: json['campeonato_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'localidade': localidade,
      'escudo_url': escudoUrl,
      'campeonato_id': campeonatoId,
    };
  }
}
