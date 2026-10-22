import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datos/errores_activacion.dart';
import '../datos/repositorio_activacion.dart';
import '../datos/repositorio_activacion_mock.dart';
import 'estado_activacion.dart';

/// Repositorio de activación. Por ahora siempre es el mock: no hay backend conectado.
/// Los tests lo reemplazan con `overrides`.
final repositorioActivacionProvider = Provider<RepositorioActivacion>((ref) {
  return RepositorioActivacionMock();
});

final controladorActivacionProvider =
    NotifierProvider<ControladorActivacion, EstadoActivacion>(
  ControladorActivacion.new,
);

class ControladorActivacion extends Notifier<EstadoActivacion> {
  @override
  EstadoActivacion build() => const EstadoInicial();

  Future<void> activar(String clave) async {
    if (state is EstadoCargando) {
      return;
    }

    state = const EstadoCargando();

    try {
      await ref.read(repositorioActivacionProvider).activar(clave);
      state = const EstadoExito();
    } on ErrorActivacion catch (error) {
      state = EstadoError(error.mensaje);
    }
  }
}
