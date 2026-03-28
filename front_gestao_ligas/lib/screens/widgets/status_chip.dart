import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../models/campeonato.dart';

/// Chip de status do campeonato
class StatusChip extends StatelessWidget {
  final StatusCampeonato status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final statusCamp = switch (status) {
      StatusCampeonato.emAndamento => ['Em Andamento', AppTheme.statusEmAndamento],
      StatusCampeonato.naoIniciado => ['Não Iniciado', AppTheme.statusAgendada],
      StatusCampeonato.encerrado => ['Encerrado', AppTheme.statusEncerrado],
    };
    return Chip(
      label: Text(
        statusCamp[0] as String,
        style: TextStyle(
          color:Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: statusCamp[1] as Color,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
