import 'package:flutter/material.dart';

import '../core/theme/colores.dart';
import '../core/theme/espaciado.dart';

/// Marca de AgroVision, dibujada con CustomPainter a partir de los 9 polígonos
/// del logo de la web (viewBox 280 x 235). Solo trazo, sin relleno.
///
/// [progreso] va de 0 a 1 y dibuja los triángulos uno tras otro.
/// Con 1 (valor por defecto) el logo queda completo.
class LogoAgroVision extends StatelessWidget {
  const LogoAgroVision({
    super.key,
    this.altura = EspaciadoAgroVision.logoAltura,
    this.color = ColoresAgroVision.azul,
    this.progreso = 1,
  });

  final double altura;
  final Color color;
  final double progreso;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(altura * _ancho / _alto, altura),
      painter: _PintorLogo(color: color, progreso: progreso),
    );
  }

  static const double _ancho = 280;
  static const double _alto = 235;
}

class _PintorLogo extends CustomPainter {
  _PintorLogo({required this.color, required this.progreso});

  final Color color;
  final double progreso;

  // Mismos puntos que el SVG de la web.
  static const List<List<Offset>> _poligonos = [
    [Offset(100, 75), Offset(180, 75), Offset(140, 5)],
    [Offset(60, 150), Offset(140, 150), Offset(100, 80)],
    [Offset(100, 80), Offset(180, 80), Offset(140, 150)],
    [Offset(140, 150), Offset(220, 150), Offset(180, 80)],
    [Offset(20, 225), Offset(100, 225), Offset(60, 155)],
    [Offset(60, 155), Offset(140, 155), Offset(100, 225)],
    [Offset(100, 225), Offset(180, 225), Offset(140, 155)],
    [Offset(140, 155), Offset(220, 155), Offset(180, 225)],
    [Offset(180, 225), Offset(260, 225), Offset(220, 155)],
  ];

  // Grosor del trazo en unidades del viewBox, igual que el panel web.
  static const double _grosor = 2.2;

  @override
  void paint(Canvas canvas, Size size) {
    final escala = size.width / 280;
    final pincel = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _grosor * escala
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final cantidad = _poligonos.length;
    for (var i = 0; i < cantidad; i++) {
      // Cada triángulo ocupa una porción del progreso total.
      final inicio = i / cantidad;
      final avance = ((progreso - inicio) * cantidad).clamp(0.0, 1.0);
      if (avance == 0) {
        continue;
      }

      final camino = _caminoPoligono(_poligonos[i], escala);
      final medida = camino.computeMetrics().first;
      canvas.drawPath(medida.extractPath(0, medida.length * avance), pincel);
    }
  }

  Path _caminoPoligono(List<Offset> puntos, double escala) {
    final camino = Path()..moveTo(puntos[0].dx * escala, puntos[0].dy * escala);
    for (final punto in puntos.skip(1)) {
      camino.lineTo(punto.dx * escala, punto.dy * escala);
    }
    return camino..close();
  }

  @override
  bool shouldRepaint(_PintorLogo viejo) {
    return viejo.color != color || viejo.progreso != progreso;
  }
}
