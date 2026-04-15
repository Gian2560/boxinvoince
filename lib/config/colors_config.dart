// Configuración de colores coherente para la aplicación
// Esquema de colores moderno con tonos azules y verdes para una app de música

import 'package:flutter/material.dart';

class ColorsConfig {
  // Colores primarios
  static const Color primary = Color(0xFF1976D2); // Azul principal
  static const Color primaryVariant = Color(0xFF1565C0); // Azul más oscuro
  static const Color onPrimary = Color(
    0xFFFFFFFF,
  ); // Texto sobre primary (blanco)

  // Colores secundarios
  static const Color secondary = Color(0xFF4CAF50); // Verde secundario
  static const Color secondaryVariant = Color(0xFF388E3C); // Verde más oscuro
  static const Color onSecondary = Color(
    0xFFFFFFFF,
  ); // Texto sobre secondary (blanco)

  // Colores de superficie y fondo
  static const Color background = Color(0xFFF5F5F5); // Fondo gris claro
  static const Color onBackground = Color(
    0xFF212121,
  ); // Texto sobre background (negro)
  static const Color surface = Color(0xFFFFFFFF); // Superficie blanca
  static const Color onSurface = Color(
    0xFF212121,
  ); // Texto sobre surface (negro)

  // Colores de acento y error
  static const Color accent = Color(0xFFFF9800); // Naranja acento
  static const Color error = Color(0xFFF44336); // Rojo error
  static const Color onError = Color(0xFFFFFFFF); // Texto sobre error (blanco)

  // Colores adicionales para componentes UI
  static const Color cardBackground = Color(0xFFFFFFFF); // Fondo de tarjetas
  static const Color divider = Color(0xFFBDBDBD); // Divisores
  static const Color hintText = Color(0xFF9E9E9E); // Texto de sugerencia
  static const Color disabled = Color(0xFFBDBDBD); // Elementos deshabilitados

  // Colores para botones
  static const Color buttonPrimary = primary;
  static const Color buttonSecondary = secondary;
  static const Color buttonDisabled = disabled;
  static const Color buttonTextPrimary = onPrimary;
  static const Color buttonTextSecondary = onSecondary;
  static const Color buttonLoadingIndicator = onPrimary;
  static Color getPrimaryColor() => primary;
  static Color getSecondaryColor() => secondary;
  static Color getBackgroundColor() => background;
  static Color getSurfaceColor() => surface;
  static Color getErrorColor() => error;
  static Color getAccentColor() => accent;
}
