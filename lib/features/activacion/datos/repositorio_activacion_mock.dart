import 'errores_activacion.dart';
import 'repositorio_activacion.dart';

/// Implementación de prueba: no llama a ningún servidor.
///
/// Solo la clave [claveDemo] activa la app. Cualquier otra clave devuelve
/// [ClaveNoValida]. [sinConexion] permite simular la falta de red en tests.
class RepositorioActivacionMock implements RepositorioActivacion {
  RepositorioActivacionMock({
    this.demora = const Duration(milliseconds: 800),
    this.sinConexion = false,
  });

  static const String claveDemo = 'AGRO-DEMO-0001';

  final Duration demora;
  final bool sinConexion;

  @override
  Future<void> activar(String clave) async {
    await Future<void>.delayed(demora);

    if (sinConexion) {
      throw const SinConexion();
    }

    if (clave.trim().toUpperCase() != claveDemo) {
      throw const ClaveNoValida();
    }
  }
}
