import 'package:flutter/material.dart';

import '../../../core/theme/colores.dart';
import '../../../core/theme/espaciado.dart';
import '../../../core/theme/tipografia.dart';
import '../../../widgets/logo.dart';

/// Logo con el nombre de la marca y el subtítulo.
///
/// [progresoTrazo] dibuja el triángulo (0 a 1). [progresoTexto] hace aparecer
/// los textos con desvanecido y un leve desplazamiento hacia arriba (0 a 1).
class LockupAgroVision extends StatelessWidget {
  const LockupAgroVision({
    super.key,
    required this.progresoTrazo,
    required this.progresoTexto,
    required this.colorTexto,
  });

  final double progresoTrazo;
  final double progresoTexto;
  final Color colorTexto;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: EspaciadoAgroVision.alturaLockup,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LogoAgroVision(progreso: progresoTrazo),
          const SizedBox(height: EspaciadoAgroVision.sm),
          Opacity(
            opacity: progresoTexto,
            child: Transform.translate(
              offset: Offset(0, (1 - progresoTexto) * EspaciadoAgroVision.md),
              child: Column(
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text.rich(
                      TextSpan(
                        text: 'Agrovision ',
                        style: TipografiaAgroVision.marca(colorTexto),
                        children: [
                          TextSpan(
                            text: 'IA',
                            style: TipografiaAgroVision.marca(ColoresAgroVision.terra),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: EspaciadoAgroVision.xs),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'INTELIGENCIA ARTIFICIAL PARA EL CAMPO',
                      style: TipografiaAgroVision.subtitulo(ColoresAgroVision.grisSubtitulo),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
