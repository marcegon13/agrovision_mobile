/// Contrato para activar la app con una clave de licencia.
///
/// Lanza [ErrorActivacion] si la activación falla. Las implementaciones
/// concretas están en esta misma carpeta.
abstract interface class RepositorioActivacion {
  Future<void> activar(String clave);
}
