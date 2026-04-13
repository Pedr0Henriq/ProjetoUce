import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../state/classificacao_provider.dart';
import '../../widgets/state_widgets.dart';

/// Aba Artilharia e Assistências (RF 10 — Estatísticas Básicas)
class ArtilhariaTab extends StatelessWidget {
  final int campeonatoId;

  const ArtilhariaTab({super.key, required this.campeonatoId});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ClassificacaoProvider>();

    if (provider.isLoading) {
      return const LoadingState(message: 'Carregando estatísticas...');
    }

    if (provider.error != null) {
      return ErrorState(
        message: provider.error!,
        onRetry: () => provider.carregarArtilhariaEAssistencias(campeonatoId),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: const TabBar(
              labelColor: Colors.black87,
              tabs: [
                Tab(text: '⚽ Artilheiros'),
                Tab(text: '👟 Assistências'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildRanking(
                  context,
                  provider.artilheiros,
                  'Nenhum gol registrado',
                  Icons.sports_soccer,
                  'gols',
                ),
                _buildRanking(
                  context,
                  provider.assistencias,
                  'Nenhuma assistência registrada',
                  Icons.handshake,
                  'assistencias',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRanking(
    BuildContext context,
    List<Map<String, dynamic>> dados,
    String emptyMessage,
    IconData emptyIcon,
    String campo,
  ) {
    // Filtrar itens com ao menos 1 ocorrência do campo para não exibir
    // jogadores sem gols na aba de artilheiros (e vice-versa).
    final filtrados = dados
        .where((item) => ((item[campo] as num?) ?? 0) > 0)
        .toList();

    if (filtrados.isEmpty) {
      return EmptyState(
        icon: emptyIcon,
        title: emptyMessage,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: filtrados.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = filtrados[index];
        final posicao = index + 1;

        // A API retorna estrutura aninhada: {"jogador": {"nome":..., "time":...}, ...}
        final jogador = item['jogador'] as Map<String, dynamic>? ?? {};
        final time = jogador['time'] as Map<String, dynamic>? ?? {};
        final nomeJogador = jogador['nome']?.toString() ?? 'Jogador';
        final nomeTime = time['nome']?.toString() ?? '';

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: posicao <= 3
                ? [
                    Colors.amber.shade600,
                    Colors.grey.shade400,
                    Colors.brown.shade300,
                  ][posicao - 1]
                : Colors.grey.shade200,
            foregroundColor: posicao <= 3 ? Colors.white : Colors.black87,
            child: Text(
              '$posicao',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            nomeJogador,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(nomeTime),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '${item[campo] ?? 0}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}
