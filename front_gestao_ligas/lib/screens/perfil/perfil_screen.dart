import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/utils/validators.dart';
import '../../core/utils/dialog_helper.dart';
import '../../state/auth_provider.dart';

/// Tela de Perfil do Usuário (RF 12 — Seção 4.X).
///
/// Permite ao usuário visualizar e editar seus dados cadastrais
/// (nome, e-mail) e opcionalmente alterar sua senha.
/// Acessível a todos os perfis (Administrador e Analista).
class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _novaSenhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();

  bool _senhaVisivel = false;
  bool _confirmaSenhaVisivel = false;

  @override
  void initState() {
    super.initState();
    // Pré-popula os campos com os dados do usuário logado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final usuario = context.read<AuthProvider>().usuario;
      if (usuario != null) {
        _nomeController.text = usuario.nome;
        _emailController.text = usuario.email;
      }
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _novaSenhaController.dispose();
    _confirmaSenhaController.dispose();
    context.read<AuthProvider>().clearError();
    super.dispose();
  }

  /// Validador de nova senha: obrigatório apenas se o campo estiver preenchido
  String? _validarNovaSenha(String? value) {
    if (value == null || value.isEmpty) return null;
    return Validators.senha(value);
  }

  /// Validador de confirmação: obrigatório apenas se nova senha foi informada
  String? _validarConfirmacao(String? value) {
    if (_novaSenhaController.text.isEmpty) return null;
    return Validators.confirmarSenha(value, _novaSenhaController.text);
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    final dados = <String, dynamic>{
      'nome': _nomeController.text.trim(),
      'email': _emailController.text.trim(),
    };

    // Inclui nova senha apenas se informada
    if (_novaSenhaController.text.isNotEmpty) {
      dados['nova_senha'] = _novaSenhaController.text;
    }

    final auth = context.read<AuthProvider>();
    final success = await auth.atualizarPerfil(dados);

    if (mounted) {
      if (success) {
        DialogHelper.showSuccess(context, 'Perfil atualizado com sucesso!');
        context.pop();
      } else if (auth.error != null) {
        DialogHelper.showError(context, auth.error!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final usuario = auth.usuario;

    // Aguarda carregamento inicial dos dados do usuário
    if (usuario == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Inicial do nome para o avatar
    final inicial = usuario.nome.isNotEmpty
        ? usuario.nome[0].toUpperCase()
        : '?';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Avatar e informações atuais ──────────────────────────────
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 44,
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      child: Text(
                        inicial,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      usuario.nome,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      usuario.email,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    // Badge de perfil
                    Chip(
                      label: Text(
                        usuario.isAdmin ? 'Administrador' : 'Analista',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
              if (usuario.isAdmin) ...[
                SizedBox(
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () => context.push('/admin/usuarios'),
                    icon: const Icon(Icons.admin_panel_settings_outlined),
                    label: const Text('Gerenciar Usuários'),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              const Divider(),
              const SizedBox(height: 16),

              // ── Seção: Alterar Dados ─────────────────────────────────────
              Text(
                'Alterar Dados',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Campo Nome
              TextFormField(
                controller: _nomeController,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                validator: Validators.nome,
                decoration: const InputDecoration(
                  labelText: 'Nome completo',
                  prefixIcon: Icon(Icons.person_outlined),
                ),
              ),
              const SizedBox(height: 16),

              // Campo E-mail
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: Validators.email,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),

              const SizedBox(height: 28),
              const Divider(),
              const SizedBox(height: 16),

              // ── Seção: Alterar Senha (opcional) ─────────────────────────
              Text(
                'Alterar Senha (opcional)',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Deixe em branco para manter a senha atual.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
              const SizedBox(height: 16),

              // Campo Nova Senha
              TextFormField(
                controller: _novaSenhaController,
                obscureText: !_senhaVisivel,
                textInputAction: TextInputAction.next,
                validator: _validarNovaSenha,
                decoration: InputDecoration(
                  labelText: 'Nova senha',
                  prefixIcon: const Icon(Icons.lock_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _senhaVisivel
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _senhaVisivel = !_senhaVisivel),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Campo Confirmação de Senha
              TextFormField(
                controller: _confirmaSenhaController,
                obscureText: !_confirmaSenhaVisivel,
                textInputAction: TextInputAction.done,
                validator: _validarConfirmacao,
                onFieldSubmitted: (_) => _salvar(),
                decoration: InputDecoration(
                  labelText: 'Confirmar nova senha',
                  prefixIcon: const Icon(Icons.lock_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmaSenhaVisivel
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () => setState(
                        () => _confirmaSenhaVisivel = !_confirmaSenhaVisivel),
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // ── Botão Salvar ─────────────────────────────────────────────
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: auth.isLoading ? null : _salvar,
                  icon: auth.isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.save_outlined),
                  label: Text(auth.isLoading ? 'Salvando...' : 'Salvar Alterações'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
