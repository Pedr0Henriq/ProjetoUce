import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';

/// Widget do logo da aplicação Gestão de Ligas.
///
/// Exibe um container arredondado verde-escuro com o ícone de troféu amarelo.
/// Reutilizado na [SplashScreen] e na tela de login.
///
/// Parâmetros:
/// - [size]: tamanho do container do ícone (padrão 80 px)
/// - [showLabel]: se verdadeiro, exibe "Gestão de Ligas" abaixo do ícone
class AppLogo extends StatelessWidget {
  /// Tamanho do container quadrado do ícone.
  final double size;

  /// Quando verdadeiro, exibe o nome do app abaixo do ícone.
  final bool showLabel;

  const AppLogo({super.key, this.size = 80, this.showLabel = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(size * 0.28),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withValues(alpha: 0.45),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(
            Icons.emoji_events,
            size: size * 0.58,
            // Ícone amarelo para maior identidade visual
            color: AppTheme.tertiaryColor,
          ),
        ),
        if (showLabel) ...[
          SizedBox(height: size * 0.2),
          Text(
            'Gestão de Ligas',
            style: GoogleFonts.inter(
              fontSize: size * 0.26,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
        ],
      ],
    );
  }
}
