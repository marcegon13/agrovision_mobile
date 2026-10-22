import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/tema.dart';
import 'features/activacion/presentacion/pantalla_activacion.dart';

void main() {
  runApp(const ProviderScope(child: AgroVisionApp()));
}

class AgroVisionApp extends StatelessWidget {
  const AgroVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroVision',
      theme: TemaAgroVision.claro(),
      darkTheme: TemaAgroVision.oscuro(),
      home: const PantallaActivacion(),
    );
  }
}
