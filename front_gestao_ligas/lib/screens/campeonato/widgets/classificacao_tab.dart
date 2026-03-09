import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../state/classificacao_provider.dart';
import '../../widgets/state_widgets.dart';
import '../../widgets/team_shield.dart';

/// Aba Classificação (RF 09 — Classificação Automática)
class ClassificacaoTab extends StatelessWidget {
  final int campeonatoId;

  const ClassificacaoTab({super.key, required this.campeonatoId});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ClassificacaoProvider>();

    if (provider.isLoading) {
      return const LoadingState(message: 'Carregando classificação...');
    }

    if (provider.error != null) {
      return ErrorState(
        message: provider.error!,
        onRetry: () => provider.buscarClassificacao(campeonatoId),
      );
    }

    if (provider.classificacao.isEmpty) {
      return const EmptyState(
        icon: Icons.leaderboard_outlined,
        title: 'Classificação indisponível',
        subtitle: 'Registre resultados para ver a classificação.',
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: DataTable(
            columnSpacing: 12,
            headingRowColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
            ),
            columns: const [
              DataColumn(label: Text('#', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Time', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('J', style: TextStyle(fontWeight: FontWeight.bold)), numeric: true),
              DataColumn(label: Text('V', style: TextStyle(fontWeight: FontWeight.bold)), numeric: true),
              DataColumn(label: Text('E', style: TextStyle(fontWeight: FontWeight.bold)), numeric: true),
              DataColumn(label: Text('D', style: TextStyle(fontWeight: FontWeight.bold)), numeric: true),
              DataColumn(label: Text('GP', style: TextStyle(fontWeight: FontWeight.bold)), numeric: true),
              DataColumn(label: Text('GC', style: TextStyle(fontWeight: FontWeight.bold)), numeric: true),
              DataColumn(label: Text('SG', style: TextStyle(fontWeight: FontWeight.bold)), numeric: true),
              DataColumn(label: Text('PTS', style: TextStyle(fontWeight: FontWeight.bold)), numeric: true),
            ],
            rows: List.generate(provider.classificacao.length, (index) {
              final c = provider.classificacao[index];
              return DataRow(
                cells: [
                  DataCell(Text(
                    '${index + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
                  DataCell(Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TeamShield(
                        escudoUrl: c.escudoUrl,
                        nome: c.nomeTime ?? '',
                        size: 28,
                      ),
                      const SizedBox(width: 8),
                      Text(c.nomeTime ?? 'Time ${c.timeId}'),
                    ],
                  )),
                  DataCell(Text('${c.jogos}')),
                  DataCell(Text('${c.vitorias}')),
                  DataCell(Text('${c.empates}')),
                  DataCell(Text('${c.derrotas}')),
                  DataCell(Text('${c.golsPro}')),
                  DataCell(Text('${c.golsContra}')),
                  DataCell(Text(
                    '${c.saldoGols}',
                    style: TextStyle(
                      color: c.saldoGols > 0
                          ? Colors.green
                          : c.saldoGols < 0
                              ? Colors.red
                              : null,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                  DataCell(Text(
                    '${c.pontos}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
