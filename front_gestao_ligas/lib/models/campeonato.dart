enum TipoCampeonato {
  pontoCorrido('PONTOS_CORRIDOS'),
  eliminatoria('ELIMINATORIA');

  const TipoCampeonato(this.label);

  final String label;

  static String of(String name) {
    return TipoCampeonato.values
        .firstWhere((value) => value.label == name)
        .label;
  }
}

enum StatusCampeonato {
  naoIniciado('NAO_INICIADO', 'naoIniciado'),
  emAndamento('EM_ANDAMENTO', 'emAndamento'),
  encerrado('ENCERRADO', 'encerrado');

  const StatusCampeonato(this.name, this.value);

  final String name;
  final String value;

  static String of(String name) {
    return StatusCampeonato.values
        .firstWhere((value) => value.name == name)
        .value;
  }

  static String to(String value) {
    return StatusCampeonato.values
        .firstWhere((status) => status.value == value)
        .name;
  }
}

class Campeonato {
  final int id;
  final String nome;
  final String modalidade;
  final TipoCampeonato tipo;
  final int numEquipes;
  final DateTime dataInicio;
  final String status;
  final int criadoPor;

  const Campeonato({
    required this.id,
    required this.nome,
    required this.modalidade,
    required this.tipo,
    required this.numEquipes,
    required this.dataInicio,
    required this.status,
    required this.criadoPor,
  });

  factory Campeonato.fromJson(Map<String, dynamic> json) {
    final tipoRaw = (json['tipo'] ?? '').toString().toLowerCase();
    return Campeonato(
      id: json['id'] as int,
      nome: json['nome'] as String,
      modalidade: json['modalidade'] as String,
      tipo: (tipoRaw == 'ponto_corrido' || tipoRaw == 'pontos_corridos' || tipoRaw == 'pontos_corridos')
          ? TipoCampeonato.pontoCorrido
          : TipoCampeonato.eliminatoria,
      numEquipes: json['num_equipes'] as int,
      dataInicio: DateTime.parse(json['data_inicio'] as String),
      status: json['status'] as String,
      criadoPor: json['criado_por'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'modalidade': modalidade,
      'tipo': tipo == TipoCampeonato.pontoCorrido
          ? 'PONTOS_CORRIDOS'
          : 'ELIMINATORIA',
      'num_equipes': numEquipes,
      'data_inicio': dataInicio.toIso8601String(),
      'status': status,
      'criado_por': criadoPor,
    };
  }

  String get tipoFormatado =>
      tipo == TipoCampeonato.pontoCorrido ? 'Pontos Corridos' : 'Eliminatória';

  bool get isEncerrado => status == StatusCampeonato.encerrado.name;
}
