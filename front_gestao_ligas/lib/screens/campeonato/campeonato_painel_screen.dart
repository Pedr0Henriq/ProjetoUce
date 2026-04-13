import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/utils/dialog_helper.dart';
import '../../state/auth_provider.dart';
import '../../state/campeonato_provider.dart';
import '../../state/classificacao_provider.dart';
import '../../state/partida_provider.dart';
import '../../state/time_provider.dart';
import '../widgets/state_widgets.dart';
import 'widgets/classificacao_tab.dart';
import 'widgets/partidas_tab.dart';
import 'widgets/artilharia_tab.dart';
import 'widgets/times_tab.dart';

/// Painel do Campeonato com abas (Seção 4.3)
class CampeonatoPainelScreen extends StatefulWidget {
  final int campeonatoId;

  const CampeonatoPainelScreen({super.key, required this.campeonatoId});

  @override
  State<CampeonatoPainelScreen> createState() =>
      _CampeonatoPainelScreenState();
}

class _CampeonatoPainelScreenState extends State<CampeonatoPainelScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _carregarDados();
  }

  void _carregarDados() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final id = widget.campeonatoId;
      context.read<CampeonatoProvider>().buscarPorId(id);
      context.read<ClassificacaoProvider>().carregarTudo(id);
      context.read<PartidaProvider>().listarPorCampeonato(id);
      context.read<TimeProvider>().listarPorCampeonato(id);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final campProvider = context.watch<CampeonatoProvider>();
    final campeonato = campProvider.campeonatoAtual;

    return Scaffold(
      appBar: AppBar(
        title: Text(campeonato?.nome ?? 'Campeonato'),
        actions: [
          if (auth.isAdmin && campeonato != null && !campeonato.isEncerrado) ...[
            // Menu do admin
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) async {
                switch (value) {
                  case 'editar':
                    context.push('/campeonato/${widget.campeonatoId}/editar');
                    break;
                  case 'administradores':
                    context.push(
                        '/campeonato/${widget.campeonatoId}/administradores');
                    break;
                  case 'gerar_calendario':
                    final confirm = await DialogHelper.showConfirmation(
                      context,
                      title: 'Gerar Calendário',
                      message:
                          'Deseja gerar automaticamente os confrontos? Partidas existentes serão substituídas.',
                      confirmText: 'Gerar',
                    );
                    if (confirm && context.mounted) {
                      final success = await context
                          .read<PartidaProvider>()
                          .gerarCalendario(widget.campeonatoId);
                      if (context.mounted) {
                        if (success) {
                          DialogHelper.showSuccess(
                              context, 'Calendário gerado com sucesso!');
                        } else {
                          final erro = context.read<PartidaProvider>().error;
                          if (erro != null) {
                            DialogHelper.showError(context, erro);
                          } else {
                            DialogHelper.showError(context, 'Falha ao gerar o calendário.');
                          }
                        }
                      }
                    }
                    break;
                  case 'encerrar':
                    final classificacao =
                        context.read<ClassificacaoProvider>().classificacao;
                    if (classificacao.isEmpty) {
                      if (context.mounted) {
                        DialogHelper.showError(
                          context,
                          'Não é possível encerrar sem classificação disponível.',
                        );
                      }
                      break;
                    }

                    final lider = classificacao.first;
                    if (lider.timeId <= 0) {
                      if (context.mounted) {
                        DialogHelper.showError(
                          context,
                          'Não foi possível identificar o campeão pela classificação.',
                        );
                      }
                      break;
                    }

                    final nomeCampeao =
                        lider.nomeTime ?? 'Time #${lider.timeId}';
                    final confirm = await DialogHelper.showConfirmation(
                      context,
                      title: 'Encerrar Campeonato',
                      message:
                          'Deseja encerrar este campeonato?\n\nCampeão definido: $nomeCampeao\n\nNão será possível registrar novos resultados.',
                      confirmText: 'Encerrar',
                      isDangerous: true,
                    );
                    if (confirm && context.mounted) {
                      final success = await campProvider.encerrar(
                        widget.campeonatoId,
                        lider.timeId,
                      );
                      if (success && context.mounted) {
                        DialogHelper.showSuccess(
                          context,
                          'Campeonato encerrado com sucesso.',
                        );
                      }
                    }
                    break;
                  case 'excluir':
                    final confirm = await DialogHelper.showConfirmation(
                      context,
                      title: 'Excluir Campeonato',
                      message:
                          'Esta ação é irreversível. Todos os dados do campeonato serão perdidos.',
                      confirmText: 'Excluir',
                      isDangerous: true,
                    );
                    if (confirm && context.mounted) {
                      final success =
                          await campProvider.excluir(widget.campeonatoId);
                      if (success && context.mounted) {
                        context.go('/campeonatos');
                      }
                    }
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'editar',
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Editar Campeonato'),
                    dense: true,
                  ),
                ),
                const PopupMenuItem(
                  value: 'gerar_calendario',
                  child: ListTile(
                    leading: Icon(Icons.calendar_month),
                    title: Text('Gerar Calendário'),
                    dense: true,
                  ),
                ),
                // RF 17 — Gerenciar co-administradores
                const PopupMenuItem(
                  value: 'administradores',
                  child: ListTile(
                    leading: Icon(Icons.admin_panel_settings_outlined),
                    title: Text('Administradores'),
                    dense: true,
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'encerrar',
                  child: ListTile(
                    leading: Icon(Icons.flag, color: Colors.orange),
                    title: Text('Encerrar Campeonato'),
                    dense: true,
                  ),
                ),
                const PopupMenuItem(
                  value: 'excluir',
                  child: ListTile(
                    leading: Icon(Icons.delete, color: Colors.red),
                    title: Text('Excluir Campeonato',
                        style: TextStyle(color: Colors.red)),
                    dense: true,
                  ),
                ),
              ],
            ),
          ],
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.leaderboard), text: 'Classificação'),
            Tab(icon: Icon(Icons.sports_soccer), text: 'Partidas'),
            Tab(icon: Icon(Icons.stars), text: 'Artilharia'),
            Tab(icon: Icon(Icons.groups), text: 'Times'),
          ],
        ),
      ),
      body: campProvider.isLoading
          ? const LoadingState()
          : TabBarView(
              controller: _tabController,
              children: [
                ClassificacaoTab(campeonatoId: widget.campeonatoId),
                PartidasTab(campeonatoId: widget.campeonatoId),
                ArtilhariaTab(campeonatoId: widget.campeonatoId),
                TimesTab(campeonatoId: widget.campeonatoId),
              ],
            ),
    );
  }
}
