import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tema Material Design 3 da aplicação Gestão de Ligas
class AppTheme {
  AppTheme._();

  // Cores principais
  static const Color primaryColor = Color(0xFF1B5E20); // Verde escuro - remetendo a campo
  static const Color secondaryColor = Color(0xFF4CAF50); // Verde médio
  static const Color tertiaryColor = Color(0xFFFFC107); // Amarelo - destaque
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color surfaceColor = Color(0xFFF5F5F5);

  // Cores de status
  static const Color statusEmAndamento = Color(0xFF4CAF50);
  static const Color statusEncerrado = Color(0xFF9E9E9E);
  static const Color statusAgendada = Color(0xFF2196F3);

  // Cores de eventos
  static const Color golColor = Color(0xFF4CAF50);
  static const Color assistenciaColor = Color(0xFF2196F3);
  static const Color cartaoAmareloColor = Color(0xFFFFC107);
  static const Color cartaoVermelhoColor = Color(0xFFD32F2F);

  // ── Constantes de animação ──────────────────────────────────────────────────
  /// Duração rápida — micro-interações (200 ms)
  static const Duration animFast = Duration(milliseconds: 200);

  /// Duração padrão — transições de tela (350 ms)
  static const Duration animNormal = Duration(milliseconds: 350);

  /// Duração lenta — animações elaboradas (600 ms)
  static const Duration animSlow = Duration(milliseconds: 600);

  /// Duração do splash screen (1800 ms)
  static const Duration splashDuration = Duration(milliseconds: 1800);

  /// Curva padrão para entradas/saídas suaves
  static const Curve animCurveStandard = Curves.easeInOut;

  /// Curva para elementos que entram na tela
  static const Curve animCurveEnter = Curves.easeOut;

  /// Curva com efeito mola (logo no splash)
  static const Curve animCurveSpring = Curves.elasticOut;

  static ColorScheme get _colorScheme => ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: tertiaryColor,
        error: errorColor,
      );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _colorScheme,
      textTheme: GoogleFonts.interTextTheme(),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: _colorScheme.primary,
        foregroundColor: _colorScheme.onPrimary,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _colorScheme.primary,
        foregroundColor: _colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorColor: tertiaryColor,
        labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
