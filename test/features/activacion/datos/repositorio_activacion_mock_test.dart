import 'package:flutter_test/flutter_test.dart';

import 'package:agrovision_mobile/features/activacion/datos/errores_activacion.dart';
import 'package:agrovision_mobile/features/activacion/datos/repositorio_activacion_mock.dart';

void main() {
  group('RepositorioActivacionMock', () {
    test('activa con la clave de demo', () async {
      final repositorio = RepositorioActivacionMock(demora: Duration.zero);

      await expectLater(
        repositorio.activar(RepositorioActivacionMock.claveDemo),
        completes,
      );
    });

    test('acepta la clave de demo sin importar espacios ni mayúsculas', () async {
      final repositorio = RepositorioActivacionMock(demora: Duration.zero);

      await expectLater(
        repositorio.activar('  agro-demo-0001 '),
        completes,
      );
    });

    test('rechaza cualquier otra clave con error de validación', () async {
      final repositorio = RepositorioActivacionMock(demora: Duration.zero);

      await expectLater(
        repositorio.activar('AGRO-ERRONEA-9999'),
        throwsA(
          isA<ClaveNoValida>().having(
            (e) => e.mensaje,
            'mensaje',
            'Clave no válida, revisala e intentá de nuevo',
          ),
        ),
      );
    });

    test('rechaza una clave vacía con error de validación', () async {
      final repositorio = RepositorioActivacionMock(demora: Duration.zero);

      await expectLater(repositorio.activar(''), throwsA(isA<ClaveNoValida>()));
    });

    test('sin conexión lanza SinConexion aunque la clave sea correcta', () async {
      final repositorio = RepositorioActivacionMock(
        demora: Duration.zero,
        sinConexion: true,
      );

      await expectLater(
        repositorio.activar(RepositorioActivacionMock.claveDemo),
        throwsA(isA<SinConexion>()),
      );
    });
  });
}
