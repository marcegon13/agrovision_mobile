import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agrovision_mobile/features/activacion/aplicacion/controlador_activacion.dart';
import 'package:agrovision_mobile/features/activacion/aplicacion/estado_activacion.dart';
import 'package:agrovision_mobile/features/activacion/datos/repositorio_activacion_mock.dart';

ProviderContainer _contenedor() {
  final contenedor = ProviderContainer(
    overrides: [
      repositorioActivacionProvider.overrideWithValue(
        RepositorioActivacionMock(demora: Duration.zero),
      ),
    ],
  );
  addTearDown(contenedor.dispose);
  return contenedor;
}

void main() {
  test('clave válida deja el estado en éxito', () async {
    final contenedor = _contenedor();

    await contenedor
        .read(controladorActivacionProvider.notifier)
        .activar(RepositorioActivacionMock.claveDemo);

    expect(contenedor.read(controladorActivacionProvider), isA<EstadoExito>());
  });

  test('clave inválida deja el estado en error con el mensaje en español', () async {
    final contenedor = _contenedor();

    await contenedor
        .read(controladorActivacionProvider.notifier)
        .activar('CLAVE-MAL');

    final estado = contenedor.read(controladorActivacionProvider);
    expect(estado, isA<EstadoError>());
    expect(
      (estado as EstadoError).mensaje,
      'Clave no válida, revisala e intentá de nuevo',
    );
  });

  test('mientras valida pasa por el estado de carga antes del resultado', () async {
    final contenedor = _contenedor();
    final estados = <EstadoActivacion>[];
    contenedor.listen<EstadoActivacion>(
      controladorActivacionProvider,
      (anterior, nuevo) => estados.add(nuevo),
    );

    await contenedor
        .read(controladorActivacionProvider.notifier)
        .activar(RepositorioActivacionMock.claveDemo);

    expect(estados, hasLength(2));
    expect(estados[0], isA<EstadoCargando>());
    expect(estados[1], isA<EstadoExito>());
  });
}
