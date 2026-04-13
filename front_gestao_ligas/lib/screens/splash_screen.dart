import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/theme.dart';
import '../widgets/app_logo.dart';

/// Tela de apresentação do aplicativo com animação de entrada.
///
/// Exibe o logo e o nome do app com animações de escala e fade,
/// depois navega automaticamente para a tela principal.
/// O GoRouter cuida do redirecionamento baseado no estado de autenticação.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  /// Animação de escala do logo (efeito mola)
  late Animation<double> _scaleAnim;

  /// Fade do logo (primeira metade da animação)
  late Animation<double> _fadeAnim;

  /// Fade do texto (segunda metade da animação)
  late Animation<double> _labelFadeAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: AppTheme.splashDuration,
    );

    // Logo aparece com efeito mola
    _scaleAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    // Logo faz fade nos primeiros 50%
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    // Texto faz fade nos últimos 50%
    _labelFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 0.85, curve: Curves.easeIn),
      ),
    );

    // Inicia animação e navega ao final
    _controller.forward().then((_) {
      if (mounted) {
        // Pequena pausa antes de navegar para não ser abrupto
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) {
            // GoRouter redirect lida com auth → /campeonatos ou /login
            context.go('/campeonatos');
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo com animação de fade + escala
                FadeTransition(
                  opacity: _fadeAnim,
                  child: ScaleTransition(
                    scale: _scaleAnim,
                    child: const AppLogo(size: 110),
                  ),
                ),

                const SizedBox(height: 28),

                // Nome do aplicativo
                FadeTransition(
                  opacity: _labelFadeAnim,
                  child: Text(
                    'Gestão de Ligas',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Slogan
                FadeTransition(
                  opacity: _labelFadeAnim,
                  child: Text(
                    'Organize seus campeonatos',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white.withValues(alpha: 0.75),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
