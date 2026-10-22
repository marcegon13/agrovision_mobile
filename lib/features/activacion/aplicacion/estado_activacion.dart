/// Estados explícitos de la activación. No se usan booleanos sueltos.
sealed class EstadoActivacion {
  const EstadoActivacion();
}

class EstadoInicial extends EstadoActivacion {
  const EstadoInicial();
}

class EstadoCargando extends EstadoActivacion {
  const EstadoCargando();
}

class EstadoError extends EstadoActivacion {
  const EstadoError(this.mensaje);

  final String mensaje;
}

class EstadoExito extends EstadoActivacion {
  const EstadoExito();
}
