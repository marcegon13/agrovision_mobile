import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agrovision_mobile/features/activacion/aplicacion/controlador_activacion.dart';
import 'package:agrovision_mobile/features/activacion/datos/repositorio_activacion_mock.dart';
import 'package:agrovision_mobile/features/activacion/presentacion/pantalla_activacion.dart';

const _textoSubtitulo = 'INTELIGENCIA ARTIFICIAL PARA EL CAMPO';

/// Monta la pantalla. Por defecto sin animaciones, para que los tests de estado
/// no dependan de los tiempos de la entrada.
Future<void> _montar(
  WidgetTester tester, {
  bool sinConexion = false,
  bool sinAnimaciones = true,
}) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [
        repositorioActivacionProvider.overrideWithValue(
          RepositorioActivacionMock(
            demora: const Duration(milliseconds: 500),
            sinConexion: sinConexion,
          ),
        ),
      ],
      child: MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(disableAnimations: sinAnimaciones),
          child: child!,
        ),
        home: const PantallaActivacion(),
      ),
    ),
  );
}

Future<void> _escribirYActivar(WidgetTester tester, String clave) async {
  await tester.enterText(find.byType(TextField), clave);
  await tester.tap(find.text('Activar'));
}

/// Opacidad del Opacity que envuelve un texto.
double _opacidadDe(WidgetTester tester, Finder texto) {
  Opacity? masCercano;
  tester.element(texto).visitAncestorElements((elemento) {
    if (elemento.widget is Opacity) {
      masCercano = elemento.widget as Opacity;
      return false;
    }
    return true;
  });
  return masCercano!.opacity;
}

void main() {
  testWidgets('estado inicial: muestra el título, el campo y el botón habilitado', (tester) async {
    await _montar(tester);

    expect(find.text('Activá tu AgroVision'), findsOneWidget);
    expect(find.text('Clave de licencia'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    final boton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(boton.onPressed, isNotNull);
  });

  testWidgets('estado cargando: muestra el indicador y bloquea el botón', (tester) async {
    await _montar(tester);

    await _escribirYActivar(tester, RepositorioActivacionMock.claveDemo);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Activar'), findsNothing);

    final boton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(boton.onPressed, isNull);

    await tester.pumpAndSettle();
  });

  testWidgets('clave válida: lleva a la pantalla de bienvenida', (tester) async {
    await _montar(tester);

    await _escribirYActivar(tester, RepositorioActivacionMock.claveDemo);
    await tester.pumpAndSettle();

    expect(find.text('Bienvenido'), findsOneWidget);
    expect(find.text('Activá tu AgroVision'), findsNothing);
  });

  testWidgets('clave inválida: muestra el error y se queda en la pantalla', (tester) async {
    await _montar(tester);

    await _escribirYActivar(tester, 'AGRO-MAL-0000');
    await tester.pumpAndSettle();

    expect(find.text('Clave no válida, revisala e intentá de nuevo'), findsOneWidget);
    expect(find.text('Bienvenido'), findsNothing);
    expect(find.text('Activar'), findsOneWidget);
  });

  testWidgets('sin conexión: muestra el mensaje de conexión', (tester) async {
    await _montar(tester, sinConexion: true);

    await _escribirYActivar(tester, RepositorioActivacionMock.claveDemo);
    await tester.pumpAndSettle();

    expect(
      find.text('Sin conexión. Revisá tu internet e intentá de nuevo'),
      findsOneWidget,
    );
    expect(find.text('Bienvenido'), findsNothing);
  });

  testWidgets('con movimiento reducido, el lockup queda en su estado final sin animaciones', (tester) async {
    await _montar(tester);
    await tester.pump();

    expect(tester.hasRunningAnimations, isFalse);
    expect(find.text(_textoSubtitulo), findsOneWidget);
    expect(_opacidadDe(tester, find.text(_textoSubtitulo)), 1);
  });

  testWidgets('sin movimiento reducido, la entrada corre y al terminar muestra el formulario', (tester) async {
    await _montar(tester, sinAnimaciones: false);
    await tester.pump();

    expect(tester.hasRunningAnimations, isTrue);

    await tester.pumpAndSettle();

    expect(tester.hasRunningAnimations, isFalse);
    expect(_opacidadDe(tester, find.byType(TextField)), 1);
    expect(_opacidadDe(tester, find.text('Activar')), 1);
  });
}
