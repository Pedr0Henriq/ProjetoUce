import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../models/campeonato.dart';

/// Chip de status do campeonato
class StatusChip extends StatelessWidget {
  final StatusCampeonato status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final isAndamento = status == StatusCampeonato.emAndamento;
    return Chip(
      label: Text(
        isAndamento ? 'Em andamento' : 'Encerrado',
        style: TextStyle(
          color: isAndamento ? Colors.white : Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: isAndamento
          ? AppTheme.statusEmAndamento
          : AppTheme.statusEncerrado,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
