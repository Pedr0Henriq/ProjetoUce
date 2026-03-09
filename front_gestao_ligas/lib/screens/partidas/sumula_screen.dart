import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utils/date_formatters.dart';
import '../../core/theme.dart';
import '../../state/partida_provider.dart';
import '../../models/models.dart';
import '../widgets/state_widgets.dart';
import '../widgets/team_shield.dart';

/// Tela de Súmula Eletrônica (Seção 4.6 - RF 16)
class SumulaScreen extends StatefulWidget {
  final int partidaId;

  const SumulaScreen({super.key, required this.partidaId});

  @override
  State<SumulaScreen> createState() => _SumulaScreenState();
}

class _SumulaScreenState extends State<SumulaScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PartidaProvider>().buscarPorId(widget.partidaId);
      context.read<PartidaProvider>().listarEventos(widget.partidaId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PartidaProvider>();
    final partida = provider.partidaAtual;
    final eventos = provider.eventosPartida;

    if (provider.isLoading || partida == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Súmula Eletrônica')),
        body: const LoadingState(),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Súmula Eletrônica')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Info da partida: data, horário, local
          Card(
            color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 6),
                      Text(DateFormatters.data(partida.data)),
                      const SizedBox(width: 16),
                      const Icon(Icons.access_time, size: 16),
                      const SizedBox(width: 6),
                      Text(DateFormatters.hora(partida.horario)),
                    ],
                  ),
                  if (partida.local != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on, size: 16),
                        const SizedBox(width: 6),
                        Flexible(child: Text(partida.local!)),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Placar destacado
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Row(
                children: [
                  // Mandante
                  Expanded(
                    child: Column(
                      children: [
                        TeamShield(
                          escudoUrl: partida.escudoMandante,
                          nome: partida.nomeMandante ?? '',
                          size: 64,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          partida.nomeMandante ?? 'Mandante',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  // Placar
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '${partida.golsMandante ?? 0}  x  ${partida.golsVisitante ?? 0}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // Visitante
                  Expanded(
                    child: Column(
                      children: [
                        TeamShield(
                          escudoUrl: partida.escudoVisitante,
                          nome: partida.nomeVisitante ?? '',
                          size: 64,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          partida.nomeVisitante ?? 'Visitante',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Linha do tempo de eventos
          Text(
            'Eventos da Partida',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          if (eventos.isEmpty)
            const EmptyState(
              icon: Icons.event_note_outlined,
              title: 'Nenhum evento registrado',
            )
          else
            ...eventos.map((evento) => _EventoTimeline(
                  evento: evento,
                  isMandante: evento.timeId == partida.timeMandanteId,
                )),
        ],
      ),
    );
  }
}

class _EventoTimeline extends StatelessWidget {
  final EventoPartida evento;
  final bool isMandante;

  const _EventoTimeline({required this.evento, required this.isMandante});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // Minuto
          SizedBox(
            width: 48,
            child: Text(
              evento.minuto != null ? "${evento.minuto}'" : '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Linha vertical
          Container(
            width: 3,
            height: 40,
            color: _eventoColor,
          ),
          const SizedBox(width: 12),

          // Ícone
          _buildIcon(),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  evento.nomeJogador ?? 'Jogador',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  '${evento.tipoFormatado} • ${evento.nomeTime ?? ""}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color get _eventoColor {
    switch (evento.tipo) {
      case TipoEvento.gol:
        return AppTheme.golColor;
      case TipoEvento.assistencia:
        return AppTheme.assistenciaColor;
      case TipoEvento.cartaoAmarelo:
        return AppTheme.cartaoAmareloColor;
      case TipoEvento.cartaoVermelho:
        return AppTheme.cartaoVermelhoColor;
    }
  }

  Widget _buildIcon() {
    IconData iconData;
    switch (evento.tipo) {
      case TipoEvento.gol:
        iconData = Icons.sports_soccer;
        break;
      case TipoEvento.assistencia:
        iconData = Icons.handshake;
        break;
      case TipoEvento.cartaoAmarelo:
        iconData = Icons.square;
        break;
      case TipoEvento.cartaoVermelho:
        iconData = Icons.square;
        break;
    }

    return CircleAvatar(
      radius: 16,
      backgroundColor: _eventoColor.withValues(alpha: 0.2),
      child: Icon(iconData, size: 16, color: _eventoColor),
    );
  }
}
