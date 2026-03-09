import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/dialog_helper.dart';
import '../../../state/auth_provider.dart';
import '../../../state/time_provider.dart';
import '../../../state/jogador_provider.dart';
import '../../../models/jogador.dart';
import '../../widgets/state_widgets.dart';
import '../../widgets/team_shield.dart';

/// Tela de Ficha do Time (Seção 4.5 - RF 05, RF 06, RF 13)
class TimeFichaScreen extends StatefulWidget {
  final int timeId;
  final int campeonatoId;

  const TimeFichaScreen({
    super.key,
    required this.timeId,
    required this.campeonatoId,
  });

  @override
  State<TimeFichaScreen> createState() => _TimeFichaScreenState();
}

class _TimeFichaScreenState extends State<TimeFichaScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TimeProvider>().buscarPorId(widget.timeId);
      context.read<JogadorProvider>().listarPorTime(widget.timeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = context.watch<AuthProvider>().isAdmin;
    final timeProvider = context.watch<TimeProvider>();
    final jogadorProvider = context.watch<JogadorProvider>();
    final time = timeProvider.timeAtual;

    return Scaffold(
      appBar: AppBar(
        title: Text(time?.nome ?? 'Time'),
        actions: [
          if (isAdmin && time != null)
            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'excluir') {
                  final confirm = await DialogHelper.showConfirmation(
                    context,
                    title: 'Excluir Time',
                    message:
                        'Esta ação é irreversível. O time e todos os jogadores serão removidos.',
                    confirmText: 'Excluir',
                    isDangerous: true,
                  );
                  if (confirm && context.mounted) {
                    final success =
                        await timeProvider.excluir(widget.timeId);
                    if (success && context.mounted) {
                      context.pop();
                    }
                  }
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'excluir',
                  child: ListTile(
                    leading: Icon(Icons.delete, color: Colors.red),
                    title: Text('Excluir Time',
                        style: TextStyle(color: Colors.red)),
                    dense: true,
                  ),
                ),
              ],
            ),
        ],
      ),
      body: timeProvider.isLoading
          ? const LoadingState()
          : time == null
              ? const ErrorState(message: 'Time não encontrado.')
              : RefreshIndicator(
                  onRefresh: () async {
                    await context
                        .read<TimeProvider>()
                        .buscarPorId(widget.timeId);
                    if (context.mounted) {
                      await context
                          .read<JogadorProvider>()
                          .listarPorTime(widget.timeId);
                    }
                  },
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // Header com escudo e info
                      Center(
                        child: Column(
                          children: [
                            TeamShield(
                              escudoUrl: time.escudoUrl,
                              nome: time.nome,
                              size: 80,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              time.nome,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.location_on,
                                    size: 16, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  time.localidade,
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 16),

                      // Seção Jogadores
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Elenco',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          if (isAdmin)
                            TextButton.icon(
                              onPressed: () => context.push(
                                '/campeonato/${widget.campeonatoId}/time/${widget.timeId}/jogador',
                              ),
                              icon: const Icon(Icons.person_add, size: 18),
                              label: const Text('Adicionar'),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      if (jogadorProvider.isLoading)
                        const Padding(
                          padding: EdgeInsets.all(32),
                          child: LoadingState(
                              message: 'Carregando jogadores...'),
                        )
                      else if (jogadorProvider.jogadores.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(32),
                          child: EmptyState(
                            icon: Icons.person_outline,
                            title: 'Nenhum jogador cadastrado',
                          ),
                        )
                      else
                        ...jogadorProvider.jogadores.map((jogador) =>
                            _JogadorTile(
                              jogador: jogador,
                              isAdmin: isAdmin,
                            )),
                    ],
                  ),
                ),
    );
  }
}

class _JogadorTile extends StatelessWidget {
  final Jogador jogador;
  final bool isAdmin;

  const _JogadorTile({required this.jogador, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            jogador.numero?.toString() ?? '-',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        title: Text(
          jogador.nome,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(jogador.posicao),
        trailing: isAdmin
            ? IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () async {
                  final confirm = await DialogHelper.showConfirmation(
                    context,
                    title: 'Remover Jogador',
                    message: 'Deseja remover ${jogador.nome} do time?',
                    confirmText: 'Remover',
                    isDangerous: true,
                  );
                  if (confirm && context.mounted) {
                    context.read<JogadorProvider>().excluir(jogador.id);
                  }
                },
              )
            : null,
      ),
    );
  }
}
