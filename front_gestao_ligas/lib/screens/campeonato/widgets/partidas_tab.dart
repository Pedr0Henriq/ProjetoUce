import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/date_formatters.dart';
import '../../../core/theme.dart';
import '../../../state/auth_provider.dart';
import '../../../state/partida_provider.dart';
import '../../../models/partida.dart';
import '../../widgets/state_widgets.dart';
import '../../widgets/team_shield.dart';

/// Aba Partidas (RF 08 — Cadastrar e Gerenciar Partidas)
class PartidasTab extends StatelessWidget {
  final int campeonatoId;

  const PartidasTab({super.key, required this.campeonatoId});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PartidaProvider>();
    final isAdmin = context.watch<AuthProvider>().isAdmin;

    if (provider.isLoading) {
      return const LoadingState(message: 'Carregando partidas...');
    }

    if (provider.error != null) {
      return ErrorState(
        message: provider.error!,
        onRetry: () => provider.listarPorCampeonato(campeonatoId),
      );
    }

    if (provider.partidas.isEmpty) {
      return EmptyState(
        icon: Icons.sports_soccer_outlined,
        title: 'Nenhuma partida cadastrada',
        subtitle: isAdmin ? 'Gere o calendário ou adicione partidas.' : null,
      );
    }

    final porRodada = provider.partidasPorRodada;

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: porRodada.length,
      itemBuilder: (context, index) {
        final rodada = porRodada.keys.elementAt(index);
        final partidas = porRodada[rodada]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header da rodada
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                'Rodada $rodada',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            // Partidas da rodada
            ...partidas.map((partida) => _PartidaCard(
                  partida: partida,
                  campeonatoId: campeonatoId,
                  isAdmin: isAdmin,
                )),
            if (index < porRodada.length - 1) const Divider(height: 24),
          ],
        );
      },
    );
  }
}

class _PartidaCard extends StatelessWidget {
  final Partida partida;
  final int campeonatoId;
  final bool isAdmin;

  const _PartidaCard({
    required this.partida,
    required this.campeonatoId,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: partida.isFinalizada
            ? () => context.push(
                '/campeonato/$campeonatoId/partida/${partida.id}/sumula')
            : null,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // Data e local
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${DateFormatters.data(partida.data)} • ${DateFormatters.hora(partida.horario)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                  if (partida.local != null)
                    Flexible(
                      child: Text(
                        partida.local!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade500,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),

              // Confronto
              Row(
                children: [
                  // Mandante
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            partida.nomeMandante ?? 'Time A',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        TeamShield(
                          escudoUrl: partida.escudoMandante,
                          nome: partida.nomeMandante ?? '',
                          size: 32,
                        ),
                      ],
                    ),
                  ),

                  // Placar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: partida.isFinalizada
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      partida.isFinalizada
                          ? '${partida.golsMandante ?? 0} x ${partida.golsVisitante ?? 0}'
                          : 'x',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: partida.isFinalizada ? 18 : 14,
                        color: partida.isFinalizada
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                      ),
                    ),
                  ),

                  // Visitante
                  Expanded(
                    child: Row(
                      children: [
                        TeamShield(
                          escudoUrl: partida.escudoVisitante,
                          nome: partida.nomeVisitante ?? '',
                          size: 32,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            partida.nomeVisitante ?? 'Time B',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Ações do admin
              if (isAdmin && !partida.isFinalizada) ...[
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () => context.push(
                        '/campeonato/$campeonatoId/partida/${partida.id}/resultado',
                      ),
                      icon: const Icon(Icons.edit_note, size: 20),
                      label: const Text('Registrar Resultado'),
                    ),
                  ],
                ),
              ],

              // Indicador visual para partidas finalizadas
              if (partida.isFinalizada)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle,
                          size: 14, color: AppTheme.statusEmAndamento),
                      const SizedBox(width: 4),
                      Text(
                        'Finalizada • Toque para ver a súmula',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade500,
                              fontSize: 11,
                            ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
