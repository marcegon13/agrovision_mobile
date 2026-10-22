import 'package:flutter/material.dart';

import 'colores.dart';
import 'espaciado.dart';
import 'tipografia.dart';

/// Temas de AgroVision: claro por defecto y oscuro según el sistema.
abstract final class TemaAgroVision {
  static ThemeData claro() {
    const colorScheme = ColorScheme.light(
      primary: ColoresAgroVision.azul,
      onPrimary: ColoresAgroVision.blanco,
      primaryContainer: ColoresAgroVision.azulFondo,
      onPrimaryContainer: ColoresAgroVision.navy,
      secondary: ColoresAgroVision.azulClaro,
      onSecondary: ColoresAgroVision.navy,
      surface: ColoresAgroVision.blanco,
      onSurface: ColoresAgroVision.gris800,
      onSurfaceVariant: ColoresAgroVision.gris600,
      surfaceContainerHighest: ColoresAgroVision.gris100,
      outline: ColoresAgroVision.gris700,
    );

    return _construir(
      colorScheme: colorScheme,
      fondo: ColoresAgroVision.gris50,
      textoPrincipal: ColoresAgroVision.gris800,
    );
  }

  static ThemeData oscuro() {
    const colorScheme = ColorScheme.dark(
      primary: ColoresAgroVision.azul,
      onPrimary: ColoresAgroVision.blanco,
      primaryContainer: ColoresAgroVision.navy2,
      onPrimaryContainer: ColoresAgroVision.azulClaro,
      secondary: ColoresAgroVision.azulClaro,
      onSecondary: ColoresAgroVision.navy,
      surface: ColoresAgroVision.navy2,
      onSurface: ColoresAgroVision.textoOscuro,
      onSurfaceVariant: ColoresAgroVision.azulClaro,
      surfaceContainerHighest: ColoresAgroVision.navy,
      error: ColoresAgroVision.errorOscuro,
      outline: ColoresAgroVision.azulClaro,
    );

    return _construir(
      colorScheme: colorScheme,
      fondo: ColoresAgroVision.navy,
      textoPrincipal: ColoresAgroVision.textoOscuro,
    );
  }

  static ThemeData _construir({
    required ColorScheme colorScheme,
    required Color fondo,
    required Color textoPrincipal,
  }) {
    final bordeRedondeado = BorderRadius.circular(EspaciadoAgroVision.radioMediano);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: fondo,
      textTheme: TipografiaAgroVision.textTheme(textoPrincipal),
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: bordeRedondeado),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: EspaciadoAgroVision.md,
          vertical: EspaciadoAgroVision.sm,
        ),
        border: OutlineInputBorder(borderRadius: bordeRedondeado),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(
            horizontal: EspaciadoAgroVision.lg,
            vertical: EspaciadoAgroVision.md,
          ),
          shape: RoundedRectangleBorder(borderRadius: bordeRedondeado),
        ),
      ),
    );
  }
}
