import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utils/dialog_helper.dart';
import '../../models/usuario.dart';
import '../../state/auth_provider.dart';
import '../../state/usuarios_admin_provider.dart';
import '../widgets/state_widgets.dart';

class UsuariosAdminScreen extends StatefulWidget {
  const UsuariosAdminScreen({super.key});

  @override
  State<UsuariosAdminScreen> createState() => _UsuariosAdminScreenState();
}

class _UsuariosAdminScreenState extends State<UsuariosAdminScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UsuariosAdminProvider>().carregarUsuarios();
    });
  }

  Future<void> _promoverUsuario(Usuario usuario) async {
    final confirm = await DialogHelper.showConfirmation(
      context,
      title: 'Promover Usuário',
      message: 'Deseja promover ${usuario.nome} para Administrador?',
      confirmText: 'Promover',
    );

    if (!confirm || !mounted) return;

    final provider = context.read<UsuariosAdminProvider>();
    final success = await provider.promoverUsuario(usuario.id);

    if (!mounted) return;
    if (success) {
      DialogHelper.showSuccess(context, 'Usuário promovido com sucesso.');
    } else if (provider.error != null) {
      DialogHelper.showError(context, provider.error!);
    }
  }

  Future<void> _desativarUsuario(Usuario usuario) async {
    final confirm = await DialogHelper.showConfirmation(
      context,
      title: 'Desativar Usuário',
      message:
          'Deseja desativar ${usuario.nome}? O acesso será bloqueado imediatamente.',
      confirmText: 'Desativar',
      isDangerous: true,
    );

    if (!confirm || !mounted) return;

    final provider = context.read<UsuariosAdminProvider>();
    final success = await provider.desativarUsuario(usuario.id);

    if (!mounted) return;
    if (success) {
      DialogHelper.showSuccess(context, 'Usuário desativado com sucesso.');
    } else if (provider.error != null) {
      DialogHelper.showError(context, provider.error!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UsuariosAdminProvider>();
    final auth = context.watch<AuthProvider>();
    final currentUserId = auth.usuario?.id;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão de Usuários'),
      ),
      body: _buildBody(provider, currentUserId),
    );
  }

  Widget _buildBody(UsuariosAdminProvider provider, int? currentUserId) {
    if (provider.isLoading && provider.usuarios.isEmpty) {
      return const LoadingState(message: 'Carregando usuários...');
    }

    if (provider.error != null && provider.usuarios.isEmpty) {
      return ErrorState(
        message: provider.error!,
        onRetry: () => provider.carregarUsuarios(),
      );
    }

    if (provider.usuarios.isEmpty) {
      return const EmptyState(
        icon: Icons.group_off,
        title: 'Nenhum usuário encontrado',
        subtitle: 'Não há usuários cadastrados no momento.',
      );
    }

    return RefreshIndicator(
      onRefresh: provider.carregarUsuarios,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: provider.usuarios.length,
        itemBuilder: (context, index) {
          final usuario = provider.usuarios[index];
          final emAcao = provider.usuarioEstaProcessando(usuario.id);
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: usuario.ativo
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Colors.grey.shade300,
                child: Text(
                  usuario.nome.isNotEmpty
                      ? usuario.nome[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                    color: usuario.ativo
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.shade700,
                  ),
                ),
              ),
              title: Text(usuario.nome),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(usuario.email),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      Chip(
                        label: Text(
                          usuario.isAdmin ? 'Administrador' : 'Visualizador',
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                      Chip(
                        label: Text(usuario.ativo ? 'Ativo' : 'Desativado'),
                        backgroundColor:
                            usuario.ativo ? Colors.green.shade50 : Colors.red.shade50,
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                ],
              ),
              trailing: emAcao
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'promover') {
                          _promoverUsuario(usuario);
                        } else if (value == 'desativar') {
                          _desativarUsuario(usuario);
                        }
                      },
                      itemBuilder: (_) => _buildAcoesMenu(
                        usuario,
                        currentUserId,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  List<PopupMenuEntry<String>> _buildAcoesMenu(
    Usuario usuario,
    int? currentUserId,
  ) {
    final items = <PopupMenuEntry<String>>[];

    if (usuario.ativo && !usuario.isAdmin) {
      items.add(
        const PopupMenuItem<String>(
          value: 'promover',
          child: ListTile(
            leading: Icon(Icons.upgrade),
            title: Text('Promover a Admin'),
            dense: true,
          ),
        ),
      );
    }

    if (usuario.ativo && usuario.id != currentUserId) {
      items.add(
        const PopupMenuItem<String>(
          value: 'desativar',
          child: ListTile(
            leading: Icon(Icons.person_off, color: Colors.red),
            title: Text('Desativar', style: TextStyle(color: Colors.red)),
            dense: true,
          ),
        ),
      );
    }

    if (items.isEmpty) {
      items.add(
        const PopupMenuItem<String>(
          enabled: false,
          child: Text('Sem ações disponíveis'),
        ),
      );
    }

    return items;
  }
}
