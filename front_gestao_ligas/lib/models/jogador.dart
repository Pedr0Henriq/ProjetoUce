class Jogador {
  final int id;
  final String nome;
  final int? numero;
  final String posicao;
  final int timeId;

  const Jogador({
    required this.id,
    required this.nome,
    this.numero,
    required this.posicao,
    required this.timeId,
  });

  factory Jogador.fromJson(Map<String, dynamic> json) {
    return Jogador(
      id: json['id'] as int,
      nome: json['nome'] as String,
      numero: json['numero'] as int?,
      posicao: json['posicao'] as String,
      timeId: json['time_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'numero': numero,
      'posicao': posicao,
      'time_id': timeId,
    };
  }
}
