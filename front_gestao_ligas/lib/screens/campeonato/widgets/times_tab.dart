import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../state/auth_provider.dart';
import '../../../state/time_provider.dart';
import '../../../models/time.dart';
import '../../widgets/state_widgets.dart';
import '../../widgets/team_shield.dart';

/// Aba Times (RF 05 — Cadastrar e Gerenciar Times)
class TimesTab extends StatelessWidget {
  final int campeonatoId;

  const TimesTab({super.key, required this.campeonatoId});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TimeProvider>();
    final isAdmin = context.watch<AuthProvider>().isAdmin;

    if (provider.isLoading) {
      return const LoadingState(message: 'Carregando times...');
    }

    if (provider.error != null) {
      return ErrorState(
        message: provider.error!,
        onRetry: () => provider.listarPorCampeonato(campeonatoId),
      );
    }

    return Stack(
      children: [
        if (provider.times.isEmpty)
          EmptyState(
            icon: Icons.groups_outlined,
            title: 'Nenhum time cadastrado',
            subtitle: isAdmin ? 'Adicione times ao campeonato.' : null,
          )
        else
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 80),
            itemCount: provider.times.length,
            itemBuilder: (context, index) {
              final time = provider.times[index];
              return _TimeCard(time: time, campeonatoId: campeonatoId);
            },
          ),

        // FAB adicionar time (admin)
        if (isAdmin)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton.extended(
              heroTag: 'add_time',
              onPressed: () =>
                  context.push('/campeonato/$campeonatoId/criar-time'),
              icon: const Icon(Icons.add),
              label: const Text('Novo Time'),
            ),
          ),
      ],
    );
  }
}

class _TimeCard extends StatelessWidget {
  final Time time;
  final int campeonatoId;

  const _TimeCard({required this.time, required this.campeonatoId});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: TeamShield(
          escudoUrl: time.escudoUrl,
          nome: time.nome,
          size: 48,
        ),
        title: Text(
          time.nome,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(time.localidade),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(
          '/campeonato/$campeonatoId/time/${time.id}',
        ),
      ),
    );
  }
}
