/// Tokens de espaciado, radios y tamaños fijos de AgroVision.
/// Ningún widget debe usar números literales para márgenes, paddings, radios o tamaños.
abstract final class EspaciadoAgroVision {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  static const double radioChico = 8;
  static const double radioMediano = 12;
  static const double radioGrande = 16;

  static const double logoAltura = 72;
  static const double indicadorCarga = 20;
  static const double grosorIndicador = 2;
  static const double grosorBordeFocus = 2;
  static const double iconoCheck = 24;
  static const double anchoMaximoFormulario = 420;

  // Alto del bloque del logo (triángulo + textos) y del hueco para el mensaje de error.
  static const double alturaLockup = 140;
  static const double alturaSlotError = 40;
  static const double alturaBoton = 48;
}
