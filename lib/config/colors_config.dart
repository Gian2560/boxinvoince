import 'package:flutter/material.dart';

class ColorsConfig {
  // === FONDOS ===
  static const Color backgroundDark = Color(0xFF111114);      // Fondo principal app
  static const Color surfaceCard = Color(0xFF1A1A1F);         // Fondo del card/box
  static const Color surfaceIcon = Color(0xFF2C2C34);         // Fondo del ícono
  static const Color surfaceHeader = Color(0xFF1A2A1A);       // Fondo badge server

  // === MARCA ===
  static const Color brandPurple = Color(0xFF2979FF);       // Logo / accent principal

  // === TEXTO ===
  static const Color textPrimary = Colors.white;              // Títulos
  static const Color textSecondary = Color(0xFF8888A0);       // Subtítulos / hints
  static const Color textMuted = Color(0xFF666680);           // Labels pequeños

  // === BORDES ===
  static const Color borderCard = Color(0xFF2A2A32);          // Borde del card (sólido)
  static const Color borderServer = Color(0xFF2A4A2A);        // Borde badge server

  // === ESTADOS ===
  static const Color serverActive = Color(0xFF44FF88);        // Indicador server activo
  static const Color iconColor = Color(0xFFB0B0C0);           // Color ícono upload

  // === BOTONES ===
  static const Color buttonPrimary = Colors.white;            // Fondo botón principal
  static const Color buttonTextPrimary = Colors.black;        // Texto botón principal
  static const Color buttonDisabled = Color(0xFF2C2C34);      // Botón deshabilitado
  static const Color buttonLoadingIndicator = Colors.white;

  // === HELPERS ===
  static Color get cardBorderWithOpacity =>
      Colors.white.withOpacity(0.15);                         // Borde card con transparencia

  // === LEGACY (mantener compatibilidad) ===
  static const Color primary = brandPurple;
  static const Color error = Color(0xFFF44336);
  static const Color onPrimary = Colors.white;
  static Color getPrimaryColor() => primary;
  static Color getBackgroundColor() => backgroundDark;
  static Color getSurfaceColor() => surfaceCard;
  static Color getErrorColor() => error;
}