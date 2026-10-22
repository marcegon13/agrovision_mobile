import 'package:flutter/material.dart';

/// Tipografía de AgroVision: Rajdhani para títulos e Inter para el texto.
///
/// Los nombres de familia coinciden con los archivos .ttf declarados
/// en pubspec.yaml.
abstract final class TipografiaAgroVision {
  static const String familiaTitulos = 'Rajdhani';
  static const String familiaTexto = 'Inter';

  static const double espaciadoSubtitulo = 2;

  /// Nombre de la marca en el lockup del logo.
  static TextStyle marca(Color color) {
    return TextStyle(
      fontFamily: familiaTitulos,
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  /// Subtítulo del lockup, en mayúsculas y con espaciado entre letras.
  static TextStyle subtitulo(Color color) {
    return TextStyle(
      fontFamily: familiaTexto,
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: espaciadoSubtitulo,
      color: color,
    );
  }

  static TextTheme textTheme(Color color) {
    return TextTheme(
      displayLarge: TextStyle(fontFamily: familiaTitulos, fontSize: 57, fontWeight: FontWeight.w700, color: color),
      displayMedium: TextStyle(fontFamily: familiaTitulos, fontSize: 45, fontWeight: FontWeight.w700, color: color),
      displaySmall: TextStyle(fontFamily: familiaTitulos, fontSize: 36, fontWeight: FontWeight.w700, color: color),
      headlineLarge: TextStyle(fontFamily: familiaTitulos, fontSize: 32, fontWeight: FontWeight.w700, color: color),
      headlineMedium: TextStyle(fontFamily: familiaTitulos, fontSize: 28, fontWeight: FontWeight.w600, color: color),
      headlineSmall: TextStyle(fontFamily: familiaTitulos, fontSize: 24, fontWeight: FontWeight.w600, color: color),
      titleLarge: TextStyle(fontFamily: familiaTitulos, fontSize: 22, fontWeight: FontWeight.w600, color: color),
      titleMedium: TextStyle(fontFamily: familiaTexto, fontSize: 16, fontWeight: FontWeight.w600, color: color),
      titleSmall: TextStyle(fontFamily: familiaTexto, fontSize: 14, fontWeight: FontWeight.w600, color: color),
      bodyLarge: TextStyle(fontFamily: familiaTexto, fontSize: 16, fontWeight: FontWeight.w400, color: color),
      bodyMedium: TextStyle(fontFamily: familiaTexto, fontSize: 14, fontWeight: FontWeight.w400, color: color),
      bodySmall: TextStyle(fontFamily: familiaTexto, fontSize: 12, fontWeight: FontWeight.w400, color: color),
      labelLarge: TextStyle(fontFamily: familiaTexto, fontSize: 14, fontWeight: FontWeight.w600, color: color),
      labelMedium: TextStyle(fontFamily: familiaTexto, fontSize: 12, fontWeight: FontWeight.w500, color: color),
      labelSmall: TextStyle(fontFamily: familiaTexto, fontSize: 11, fontWeight: FontWeight.w500, color: color),
    );
  }
}
