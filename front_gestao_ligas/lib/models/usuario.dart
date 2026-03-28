enum PerfilUsuario { administrador, analista }

class Usuario {
  final int id;
  final String nome;
  final String email;
  final PerfilUsuario perfil;
  final DateTime criadoEm;

  const Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.perfil,
    required this.criadoEm,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as int,
      nome: json['nome'] as String,
      email: json['email'] as String,
      perfil: json['perfil'] == 'ADMIN'
          ? PerfilUsuario.administrador
          : PerfilUsuario.analista,
      criadoEm: DateTime.parse(json['criado_em'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'perfil': perfil == PerfilUsuario.administrador
          ? 'ADMIN'
          : 'VIEWER',
      'criado_em': criadoEm.toIso8601String(),
    };
  }

  bool get isAdmin => perfil == PerfilUsuario.administrador;
}
