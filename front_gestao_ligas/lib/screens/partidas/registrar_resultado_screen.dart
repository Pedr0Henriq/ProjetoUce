import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/utils/dialog_helper.dart';
import '../../core/theme.dart';
import '../../state/partida_provider.dart';
import '../../state/jogador_provider.dart';
import '../../models/models.dart';
import '../widgets/state_widgets.dart';
import '../widgets/team_shield.dart';

/// Tela de Registro de Resultado (Seção 4.4 - RF 04)
class RegistrarResultadoScreen extends StatefulWidget {
  final int partidaId;

  const RegistrarResultadoScreen({super.key, required this.partidaId});

  @override
  State<RegistrarResultadoScreen> createState() =>
      _RegistrarResultadoScreenState();
}

class _RegistrarResultadoScreenState extends State<RegistrarResultadoScreen> {
  int _golsMandante = 0;
  int _golsVisitante = 0;
  final List<Map<String, dynamic>> _eventos = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PartidaProvider>().buscarPorId(widget.partidaId);
    });
  }

  void _adicionarEvento(Partida partida) {
    String? tipoSelecionado;
    int? jogadorIdSelecionado;
    int? timeIdSelecionado;
    int? minuto;
    final minutoController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.fromLTRB(
              16, 24, 16, MediaQuery.of(ctx).viewInsets.bottom + 16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Adicionar Evento',
                    style: Theme.of(ctx).textTheme.titleLarge),
                const SizedBox(height: 16),

                // Tipo de evento
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Tipo de Evento'),
                  items: const [
                    DropdownMenuItem(value: 'gol', child: Text('⚽ Gol')),
                    DropdownMenuItem(
                        value: 'assistencia', child: Text('👟 Assistência')),
                    DropdownMenuItem(
                        value: 'cartao_amarelo',
                        child: Text('🟨 Cartão Amarelo')),
                    DropdownMenuItem(
                        value: 'cartao_vermelho',
                        child: Text('🟥 Cartão Vermelho')),
                  ],
                  onChanged: (v) => setModalState(() => tipoSelecionado = v),
                ),
                const SizedBox(height: 12),

                // Time
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(labelText: 'Time'),
                  items: [
                    DropdownMenuItem(
                      value: partida.timeMandanteId,
                      child: Text(partida.nomeMandante ?? 'Mandante'),
                    ),
                    DropdownMenuItem(
                      value: partida.timeVisitanteId,
                      child: Text(partida.nomeVisitante ?? 'Visitante'),
                    ),
                  ],
                  onChanged: (v) {
                    setModalState(() => timeIdSelecionado = v);
                    if (v != null) {
                      context.read<JogadorProvider>().listarPorTime(v);
                    }
                  },
                ),
                const SizedBox(height: 12),

                // Jogador (carregado dinamicamente)
                Consumer<JogadorProvider>(
                  builder: (ctx, jogProv, _) {
                    if (jogProv.isLoading) {
                      return const LinearProgressIndicator();
                    }
                    return DropdownButtonFormField<int>(
                      decoration:
                          const InputDecoration(labelText: 'Jogador'),
                      items: jogProv.jogadores
                          .map((j) => DropdownMenuItem(
                                value: j.id,
                                child: Text(
                                    '${j.numero != null ? "#${j.numero} " : ""}${j.nome}'),
                              ))
                          .toList(),
                      onChanged: (v) =>
                          setModalState(() => jogadorIdSelecionado = v),
                    );
                  },
                ),
                const SizedBox(height: 12),

                // Minuto — obrigatório e limitado a 0-120
                TextFormField(
                  controller: minutoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Minuto',
                    hintText: 'Ex: 45',
                  ),
                  onChanged: (v) => minuto = int.tryParse(v),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Informe o minuto do evento';
                    }
                    final n = int.tryParse(v);
                    if (n == null || n < 0 || n > 120) {
                      return 'Informe um minuto entre 0 e 120';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: (tipoSelecionado != null &&
                          jogadorIdSelecionado != null &&
                          timeIdSelecionado != null)
                      ? () {
                          if (!formKey.currentState!.validate()) return;
                          setState(() {
                            _eventos.add({
                              'tipo': tipoSelecionado,
                              'jogador_id': jogadorIdSelecionado,
                              'time_id': timeIdSelecionado,
                                'minuto': minuto!,
                              '_display_jogador': context
                                  .read<JogadorProvider>()
                                  .jogadores
                                  .firstWhere(
                                      (j) => j.id == jogadorIdSelecionado)
                                  .nome,
                              '_display_tipo': tipoSelecionado,
                            });
                            // Manter eventos ordenados por minuto para exibição
                            _eventos.sort((a, b) =>
                                ((a['minuto'] as int?) ?? 0)
                                    .compareTo((b['minuto'] as int?) ?? 0));
                          });
                          Navigator.pop(ctx);
                        }
                      : null,
                  child: const Text('Adicionar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _finalizarPartida() async {
    final confirm = await DialogHelper.showConfirmation(
      context,
      title: 'Finalizar Partida',
      message:
          'Placar: $_golsMandante x $_golsVisitante\n\nEsta operação não poderá ser desfeita. Confirma?',
      confirmText: 'Finalizar',
      isDangerous: true,
    );

    if (!confirm || !mounted) return;

    final provider = context.read<PartidaProvider>();
    final success = await provider.registrarResultado(widget.partidaId, {
      'gols_mandante': _golsMandante,
      'gols_visitante': _golsVisitante,
      'eventos': _eventos
          .map((e) => {
                'tipo': e['tipo'],
                'jogador_id': e['jogador_id'],
                'time_id': e['time_id'],
                'minuto': e['minuto'],
              })
          .toList(),
    });

    if (mounted) {
      if (success) {
        DialogHelper.showSuccess(context, 'Resultado registrado com sucesso!');
        context.pop();
      } else if (provider.error != null) {
        DialogHelper.showError(context, provider.error!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PartidaProvider>();
    final partida = provider.partidaAtual;

    if (provider.isLoading || partida == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Registrar Resultado')),
        body: const LoadingState(),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Resultado')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Escudos e placar
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // Mandante
                  Expanded(
                    child: Column(
                      children: [
                        TeamShield(
                          escudoUrl: partida.escudoMandante,
                          nome: partida.nomeMandante ?? '',
                          size: 56,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          partida.nomeMandante ?? 'Mandante',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  // Controle de placar
                  Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Gols mandante
                          _ScoreControl(
                            value: _golsMandante,
                            onIncrement: () =>
                                setState(() => _golsMandante++),
                            onDecrement: () {
                              if (_golsMandante > 0) {
                                setState(() => _golsMandante--);
                              }
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text('x',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                          // Gols visitante
                          _ScoreControl(
                            value: _golsVisitante,
                            onIncrement: () =>
                                setState(() => _golsVisitante++),
                            onDecrement: () {
                              if (_golsVisitante > 0) {
                                setState(() => _golsVisitante--);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Visitante
                  Expanded(
                    child: Column(
                      children: [
                        TeamShield(
                          escudoUrl: partida.escudoVisitante,
                          nome: partida.nomeVisitante ?? '',
                          size: 56,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          partida.nomeVisitante ?? 'Visitante',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Seção de eventos
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Eventos da Partida',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              TextButton.icon(
                onPressed: () => _adicionarEvento(partida),
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Adicionar'),
              ),
            ],
          ),
          const SizedBox(height: 8),

          if (_eventos.isEmpty)
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Nenhum evento registrado.\nToque em "Adicionar" para registrar gols, cartões e assistências.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            ..._eventos.asMap().entries.map((entry) {
              final idx = entry.key;
              final evento = entry.value;
              return Card(
                child: ListTile(
                  leading: _eventoIcon(evento['_display_tipo'] as String),
                  title: Text(evento['_display_jogador'] as String),
                  subtitle: Text(
                    evento['minuto'] != null
                        ? "Min ${evento['minuto']}"
                        : 'Minuto não informado',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () => setState(() => _eventos.removeAt(idx)),
                  ),
                ),
              );
            }),

          const SizedBox(height: 32),

          // Botão finalizar
          SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: provider.isLoading ? null : _finalizarPartida,
              icon: const Icon(Icons.check_circle),
              label: const Text('Finalizar Partida'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _eventoIcon(String tipo) {
    switch (tipo) {
      case 'gol':
        return const CircleAvatar(
          backgroundColor: AppTheme.golColor,
          radius: 16,
          child: Text('⚽', style: TextStyle(fontSize: 14)),
        );
      case 'assistencia':
        return const CircleAvatar(
          backgroundColor: AppTheme.assistenciaColor,
          radius: 16,
          child: Text('👟', style: TextStyle(fontSize: 14)),
        );
      case 'cartao_amarelo':
        return const CircleAvatar(
          backgroundColor: AppTheme.cartaoAmareloColor,
          radius: 16,
          child: Text('🟨', style: TextStyle(fontSize: 14)),
        );
      case 'cartao_vermelho':
        return const CircleAvatar(
          backgroundColor: AppTheme.cartaoVermelhoColor,
          radius: 16,
          child: Text('🟥', style: TextStyle(fontSize: 14)),
        );
      default:
        return const CircleAvatar(radius: 16, child: Icon(Icons.event));
    }
  }
}

class _ScoreControl extends StatelessWidget {
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _ScoreControl({
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onIncrement,
          icon: const Icon(Icons.add_circle, size: 32),
          color: Theme.of(context).colorScheme.primary,
        ),
        Text(
          '$value',
          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: onDecrement,
          icon: const Icon(Icons.remove_circle, size: 32),
          color: Colors.grey,
        ),
      ],
    );
  }
}
