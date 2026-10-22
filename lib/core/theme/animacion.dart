import 'package:flutter/animation.dart';

/// Duraciones, curvas y escalas de las animaciones de AgroVision.
///
/// Solo se animan transform y opacidad. Con MediaQuery.disableAnimations
/// activado, la pantalla muestra el estado final sin animar.
abstract final class AnimacionAgroVision {
  /// Dibujo del triángulo y aparición de los textos del logo.
  static const Duration entrada = Duration(milliseconds: 1200);

  /// Lockup que sube y se achica al terminar la entrada.
  static const Duration transicionLockup = Duration(milliseconds: 600);

  /// Entrada escalonada del formulario.
  static const Duration formulario = Duration(milliseconds: 500);

  /// Mensaje de error debajo del campo.
  static const Duration errorAparece = Duration(milliseconds: 200);

  /// Check del botón al validar una clave correcta.
  static const Duration check = Duration(milliseconds: 300);

  /// Pausa con el check visible antes de pasar a la pantalla de inicio.
  static const Duration pausaAntesDeInicio = Duration(milliseconds: 500);

  static const Curve curva = Curves.easeOutCubic;

  static const double escalaLockupCompacto = 0.6;
}
