/// Errores de la activación. Los mensajes van en español claro, sin códigos técnicos,
/// porque se muestran tal cual en la pantalla.
sealed class ErrorActivacion implements Exception {
  const ErrorActivacion(this.mensaje);

  final String mensaje;
}

class ClaveNoValida extends ErrorActivacion {
  const ClaveNoValida()
      : super('Clave no válida, revisala e intentá de nuevo');
}

class SinConexion extends ErrorActivacion {
  const SinConexion()
      : super('Sin conexión. Revisá tu internet e intentá de nuevo');
}

class ServicioNoDisponible extends ErrorActivacion {
  const ServicioNoDisponible()
      : super('Servicio no disponible, intenta mas tarde');
}
