import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/theme.dart';
import '../../../core/utils/date_formatters.dart';
import '../../../core/utils/dialog_helper.dart';
import '../../../state/auth_provider.dart';
import '../../../state/time_provider.dart';
import '../../../state/jogador_provider.dart';
import '../../../state/partida_provider.dart';
import '../../../models/jogador.dart';
import '../../../models/partida.dart';
import '../../widgets/state_widgets.dart';
import '../../widgets/team_shield.dart';

/// Tela de Ficha do Time (Seção 4.5 - RF 05, RF 06, RF 13).
///
/// Exibe: escudo e dados do time, elenco de jogadores e histórico de partidas.
/// O histórico (RF 13) é filtrado a partir das partidas já carregadas no
/// [PartidaProvider] pelo [CampeonatoPainelScreen] pai.
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

                      // ── Histórico de Partidas (RF 13) ─────────────────
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 16),
                      Text(
                        'Histórico de Partidas',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ..._buildHistoricoPartidas(context),
                    ],
                  ),
                ),
    );
  }

  /// RF 13 — Constrói a lista de partidas finalizadas do time.
  ///
  /// Filtra as partidas já carregadas no [PartidaProvider] por este time,
  /// sem precisar de chamada adicional à API.
  List<Widget> _buildHistoricoPartidas(BuildContext context) {
    final partidas = context
        .watch<PartidaProvider>()
        .partidas
        .where((p) =>
            p.isFinalizada &&
            (p.timeMandanteId == widget.timeId ||
                p.timeVisitanteId == widget.timeId))
        .toList()
      ..sort((a, b) =>
          (b.data ?? DateTime(0)).compareTo(a.data ?? DateTime(0)));

    if (partidas.isEmpty) {
      return [
        const Padding(
          padding: EdgeInsets.all(32),
          child: EmptyState(
            icon: Icons.history_outlined,
            title: 'Nenhuma partida finalizada',
            subtitle:
                'O histórico aparecerá aqui após o registro de resultados.',
          ),
        ),
      ];
    }

    return partidas
        .map((p) => _PartidaHistoricoTile(
              partida: p,
              timeId: widget.timeId,
              campeonatoId: widget.campeonatoId,
            ))
        .toList();
  }
}

// ── Widgets privados ────────────────────────────────────────────────────────

/// Card de um item do histórico de partidas (RF 13).
class _PartidaHistoricoTile extends StatelessWidget {
  final Partida partida;
  final int timeId;
  final int campeonatoId;

  const _PartidaHistoricoTile({
    required this.partida,
    required this.timeId,
    required this.campeonatoId,
  });

  @override
  Widget build(BuildContext context) {
    final golsM = partida.golsMandante ?? 0;
    final golsV = partida.golsVisitante ?? 0;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context
            .push('/campeonato/$campeonatoId/partida/${partida.id}/sumula'),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            children: [
              // Placar
              Row(
                children: [
                  TeamShield(
                    escudoUrl: partida.escudoMandante,
                    nome: partida.nomeMandante ?? '',
                    size: 28,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      partida.nomeMandante ?? 'Mandante',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$golsM x $golsV',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      partida.nomeVisitante ?? 'Visitante',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  TeamShield(
                    escudoUrl: partida.escudoVisitante,
                    nome: partida.nomeVisitante ?? '',
                    size: 28,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Resultado do time + data
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ResultadoChip(partida: partida, timeId: timeId),
                  if (partida.data != null)
                    Text(
                      DateFormatters.data(partida.data),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Chip colorido indicando o resultado do time (Vitória / Empate / Derrota).
class _ResultadoChip extends StatelessWidget {
  final Partida partida;
  final int timeId;

  const _ResultadoChip({required this.partida, required this.timeId});

  @override
  Widget build(BuildContext context) {
    final golsM = partida.golsMandante ?? 0;
    final golsV = partida.golsVisitante ?? 0;
    final isMandante = partida.timeMandanteId == timeId;

    final int golsTime = isMandante ? golsM : golsV;
    final int golsAdv = isMandante ? golsV : golsM;

    final String label;
    final Color color;

    if (golsTime > golsAdv) {
      label = 'Vitória';
      color = AppTheme.golColor;
    } else if (golsTime == golsAdv) {
      label = 'Empate';
      color = AppTheme.statusEncerrado;
    } else {
      label = 'Derrota';
      color = AppTheme.errorColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
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
