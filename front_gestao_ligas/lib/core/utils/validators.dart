/// Validadores de formulário reutilizáveis (NF 13 — Validação de Integridade)
class Validators {
  Validators._();

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'E-mail é obrigatório';
    }
    final regex = RegExp(r'^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,4}$');
    if (!regex.hasMatch(value.trim())) {
      return 'Formato de e-mail inválido';
    }
    return null;
  }

  static String? senha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha é obrigatória';
    }
    if (value.length < 6) {
      return 'A senha deve ter no mínimo 6 caracteres';
    }
    return null;
  }

  static String? obrigatorio(String? value, [String campo = 'Campo']) {
    if (value == null || value.trim().isEmpty) {
      return '$campo é obrigatório';
    }
    return null;
  }

  static String? nome(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nome é obrigatório';
    }
    if (value.trim().length < 2) {
      return 'Nome deve ter no mínimo 2 caracteres';
    }
    if (value.trim().length > 100) {
      return 'Nome deve ter no máximo 100 caracteres';
    }
    return null;
  }

  static String? numeroPositivo(String? value, [String campo = 'Número']) {
    if (value == null || value.trim().isEmpty) {
      return '$campo é obrigatório';
    }
    final num = int.tryParse(value.trim());
    if (num == null || num < 0) {
      return '$campo deve ser um número válido';
    }
    return null;
  }

  static String? confirmarSenha(String? value, String senha) {
    if (value == null || value.isEmpty) {
      return 'Confirmação de senha é obrigatória';
    }
    if (value != senha) {
      return 'As senhas não conferem';
    }
    return null;
  }
}
