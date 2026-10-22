import 'package:flutter/material.dart';

/// Tokens de color de AgroVision. Fuente: web pública y panel de AgroVision_Web.
/// Ningún widget debe usar colores literales: todo sale de acá.
abstract final class ColoresAgroVision {
  // Marca.
  static const Color azul = Color(0xFF1E6FFF);
  static const Color azulClaro = Color(0xFF4D9FFF);
  static const Color azulFondo = Color(0xFFEFF6FF);
  static const Color azulFondo2 = Color(0xFFE8F0FE);
  static const Color terra = Color(0xFFE05A2B);

  // Navy, usado en el fondo del tema oscuro.
  static const Color navy = Color(0xFF0A1628);
  static const Color navy2 = Color(0xFF0D1F3C);

  // Neutros claros.
  static const Color blanco = Color(0xFFFFFFFF);
  static const Color gris50 = Color(0xFFF9FAFB);
  static const Color gris100 = Color(0xFFF3F4F6);
  static const Color gris600 = Color(0xFF4B5563);
  static const Color gris700 = Color(0xFF374151);
  static const Color gris800 = Color(0xFF1F2937);

  // Texto sobre fondo oscuro (panel).
  static const Color textoOscuro = Color(0xFFF0F4FF);

  // Error, solo definido para tema oscuro (panel). Ver tema.dart.
  static const Color errorOscuro = Color(0xFFFF6B6B);
}
