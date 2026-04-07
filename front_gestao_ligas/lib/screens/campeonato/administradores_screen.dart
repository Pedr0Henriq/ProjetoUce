import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utils/validators.dart';
import '../../core/utils/dialog_helper.dart';
import '../../state/auth_provider.dart';
import '../../models/usuario.dart';
import '../widgets/state_widgets.dart';

/// Tela de Gerenciamento de Administradores (RF 17).
///
/// Permite ao administrador criador de um campeonato visualizar,
/// adicionar e remover co-administradores pelo e-mail.
///
/// Requer que o backend disponibilize:
/// - GET  /campeonatos/:id/administradores
/// - POST /campeonatos/:id/administradores  { "email": "..." }
/// - DELETE /campeonatos/:id/administradores/:userId
class AdministradoresScreen extends StatefulWidget {
  /// ID do campeonato cujos administradores serão gerenciados.
  final int campeonatoId;

  const AdministradoresScreen({super.key, required this.campeonatoId});

  @override
  State<AdministradoresScreen> createState() => _AdministradoresScreenState();
}

class _AdministradoresScreenState extends State<AdministradoresScreen> {
  final _emailController = TextEditingController();
  final _emailFormKey = GlobalKey<FormState>();

  List<Usuario> _admins = [];
  bool _isLoading = true;
  bool _isAdding = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  /// Carrega a lista de administradores do campeonato
  Future<void> _carregar() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final auth = context.read<AuthProvider>();
      final lista =
          await auth.listarAdministradoresCampeonato(widget.campeonatoId);
      setState(() {
        _admins = lista;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        // Mensagem amigável quando o endpoint ainda não está disponível
        _error = e.toString().contains('404') || e.toString().contains('500')
            ? 'Funcionalidade não disponível no servidor.\nVerifique se o backend está atualizado.'
            : e.toString();
        _isLoading = false;
      });
    }
  }

  /// Adiciona um co-administrador pelo e-mail informado
  Future<void> _adicionarAdmin() async {
    if (!_emailFormKey.currentState!.validate()) return;

    setState(() => _isAdding = true);

    try {
      final auth = context.read<AuthProvider>();
      final success = await auth.adicionarAdministrador(
        widget.campeonatoId,
        _emailController.text.trim(),
      );

      if (mounted) {
        if (success) {
          _emailController.clear();
          DialogHelper.showSuccess(context, 'Administrador adicionado!');
          await _carregar();
        } else {
          DialogHelper.showError(
            context,
            'Não foi possível adicionar. Verifique se o e-mail está cadastrado.',
          );
        }
      }
    } catch (e) {
      if (mounted) {
        DialogHelper.showError(context, e.toString());
      }
    } finally {
      if (mounted) setState(() => _isAdding = false);
    }
  }

  /// Solicita confirmação e remove um co-administrador
  Future<void> _removerAdmin(Usuario admin) async {
    final confirm = await DialogHelper.showConfirmation(
      context,
      title: 'Remover Administrador',
      message:
          'Deseja remover ${admin.nome} como administrador deste campeonato?',
      confirmText: 'Remover',
      isDangerous: true,
    );

    if (!confirm || !mounted) return;

    try {
      final auth = context.read<AuthProvider>();
      final success =
          await auth.removerAdministrador(widget.campeonatoId, admin.id);

      if (mounted) {
        if (success) {
          DialogHelper.showSuccess(context, 'Administrador removido.');
          await _carregar();
        } else {
          DialogHelper.showError(context, 'Não foi possível remover.');
        }
      }
    } catch (e) {
      if (mounted) {
        DialogHelper.showError(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuarioLogado = context.watch<AuthProvider>().usuario;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Administradores'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Recarregar',
            onPressed: _isLoading ? null : _carregar,
          ),
        ],
      ),
      body: _isLoading
          ? const LoadingState(message: 'Carregando administradores...')
          : _error != null
              ? ErrorState(
                  message: _error!,
                  onRetry: _carregar,
                )
              : _buildContent(usuarioLogado),
    );
  }

  Widget _buildContent(Usuario? usuarioLogado) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // ── Lista de administradores atuais ──────────────────────────────
        Text(
          'Administradores Atuais',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        if (_admins.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: EmptyState(
              icon: Icons.admin_panel_settings_outlined,
              title: 'Nenhum co-administrador',
              subtitle: 'Adicione administradores pelo e-mail abaixo.',
            ),
          )
        else
          ...(_admins.map((admin) => _AdminTile(
                admin: admin,
                isSelf: admin.id == usuarioLogado?.id,
                onRemove: () => _removerAdmin(admin),
              ))),

        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 16),

        // ── Adicionar co-administrador ────────────────────────────────────
        Text(
          'Adicionar por E-mail',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'O usuário precisa estar cadastrado no sistema.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
        ),
        const SizedBox(height: 16),

        Form(
          key: _emailFormKey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validator: Validators.email,
                  onFieldSubmitted: (_) => _adicionarAdmin(),
                  decoration: const InputDecoration(
                    labelText: 'E-mail do usuário',
                    prefixIcon: Icon(Icons.email_outlined),
                    hintText: 'usuario@email.com',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _isAdding ? null : _adicionarAdmin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor:
                        Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isAdding
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Adicionar'),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}

/// Tile de um administrador na lista.
class _AdminTile extends StatelessWidget {
  final Usuario admin;

  /// Se verdadeiro, é o próprio usuário logado (não pode remover a si mesmo).
  final bool isSelf;

  final VoidCallback onRemove;

  const _AdminTile({
    required this.admin,
    required this.isSelf,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final inicial = admin.nome.isNotEmpty ? admin.nome[0].toUpperCase() : '?';

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            inicial,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        title: Text(
          admin.nome,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(admin.email),
        trailing: isSelf
            // Não permite remover a si mesmo
            ? Chip(
                label: const Text('Você'),
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                padding: EdgeInsets.zero,
                labelStyle: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                tooltip: 'Remover administrador',
                onPressed: onRemove,
              ),
      ),
    );
  }
}
