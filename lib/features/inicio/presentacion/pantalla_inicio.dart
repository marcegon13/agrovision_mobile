import 'package:flutter/material.dart';

/// Pantalla de inicio. Por ahora solo muestra un saludo.
class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Bienvenido',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
