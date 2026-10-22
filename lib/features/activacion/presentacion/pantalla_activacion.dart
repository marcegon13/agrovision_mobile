import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/animacion.dart';
import '../../../core/theme/espaciado.dart';
import '../../inicio/presentacion/pantalla_inicio.dart';
import '../aplicacion/controlador_activacion.dart';
import '../aplicacion/estado_activacion.dart';
import 'lockup_agrovision.dart';

/// Pantalla para activar la app con una clave de licencia.
///
/// Secuencia: el logo se dibuja y sus textos aparecen; luego el lockup sube y
/// se achica, y aparece el formulario. Con reducción de movimiento activada
/// (MediaQuery.disableAnimations) se muestra el estado final sin animar.
class PantallaActivacion extends ConsumerStatefulWidget {
  const PantallaActivacion({super.key});

  @override
  ConsumerState<PantallaActivacion> createState() => _PantallaActivacionState();
}

class _PantallaActivacionState extends ConsumerState<PantallaActivacion>
    with TickerProviderStateMixin {
  final _clave = TextEditingController();
  String _mensajeError = '';

  late final AnimationController _entrada;
  late final AnimationController _transicion;
  late final AnimationController _formulario;
  late final AnimationController _error;
  late final AnimationController _check;

  @override
  void initState() {
    super.initState();
    _entrada = AnimationController(vsync: this, duration: AnimacionAgroVision.entrada);
    _transicion = AnimationController(vsync: this, duration: AnimacionAgroVision.transicionLockup);
    _formulario = AnimationController(vsync: this, duration: AnimacionAgroVision.formulario);
    _error = AnimationController(vsync: this, duration: AnimacionAgroVision.errorAparece);
    _check = AnimationController(vsync: this, duration: AnimacionAgroVision.check);
    Listenable.merge([_entrada, _transicion, _formulario, _error, _check]).addListener(_alAnimar);
    WidgetsBinding.instance.addPostFrameCallback((_) => _iniciarEntrada());
  }

  void _alAnimar() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _clave.dispose();
    _entrada.dispose();
    _transicion.dispose();
    _formulario.dispose();
    _error.dispose();
    _check.dispose();
    super.dispose();
  }

  void _iniciarEntrada() {
    if (!mounted || MediaQuery.disableAnimationsOf(context)) {
      return;
    }

    _entrada.forward().then((_) {
      if (!mounted) return;
      _transicion.forward().then((_) {
        if (!mounted) return;
        _formulario.forward();
      });
    });
  }

  void _activar() {
    ref.read(controladorActivacionProvider.notifier).activar(_clave.text);
  }

  void _alCambiarEstado(EstadoActivacion? anterior, EstadoActivacion nuevo) {
    switch (nuevo) {
      case EstadoError(:final mensaje):
        setState(() => _mensajeError = mensaje);
        _error.forward(from: 0);
      case EstadoCargando():
        _error.reverse();
      case EstadoExito():
        _irAInicio();
      case EstadoInicial():
        break;
    }
  }

  void _irAInicio() {
    final reducir = MediaQuery.disableAnimationsOf(context);
    if (!reducir) {
      _check.forward();
    }

    Future<void>.delayed(
      reducir ? Duration.zero : AnimacionAgroVision.pausaAntesDeInicio,
    ).then((_) {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const PantallaInicio()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<EstadoActivacion>(controladorActivacionProvider, _alCambiarEstado);

    final estado = ref.watch(controladorActivacionProvider);
    final cargando = estado is EstadoCargando;
    final exito = estado is EstadoExito;
    final hayError = estado is EstadoError;

    final reducir = MediaQuery.disableAnimationsOf(context);
    final colores = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;

    // Cada valor va de 0 a 1. Con reducción de movimiento, todo queda en el estado final.
    final tEntrada = reducir ? 1.0 : _entrada.value;
    final tTransicion = reducir ? 1.0 : AnimacionAgroVision.curva.transform(_transicion.value);
    final tFormulario = reducir ? 1.0 : AnimacionAgroVision.curva.transform(_formulario.value);
    final tError = reducir ? (hayError ? 1.0 : 0.0) : _error.value;
    final tCheck = reducir ? 1.0 : _check.value;

    // El lockup arranca centrado en la pantalla y sube hasta el borde superior.
    final alturaPantalla = MediaQuery.sizeOf(context).height;
    final margenSuperior = MediaQuery.paddingOf(context).top + EspaciadoAgroVision.md;
    final dyInicial = _positivo(
      alturaPantalla / 2 - EspaciadoAgroVision.alturaLockup / 2 - margenSuperior,
    );
    final desplazamientoLockup = dyInicial * (1 - tTransicion);
    final escalaLockup =
        1 + (AnimacionAgroVision.escalaLockupCompacto - 1) * tTransicion;

    final opacidadFormulario = _tramo(tFormulario, 0, 0.6);
    final opacidadBoton = _tramo(tFormulario, 0.4, 1);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(EspaciadoAgroVision.md),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: EspaciadoAgroVision.anchoMaximoFormulario,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Transform.translate(
                    offset: Offset(0, desplazamientoLockup),
                    child: Transform.scale(
                      scale: escalaLockup,
                      alignment: Alignment.topCenter,
                      child: LockupAgroVision(
                        progresoTrazo: _tramo(tEntrada, 0, 0.6),
                        progresoTexto: _tramo(tEntrada, 0.5, 1),
                        colorTexto: colores.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: EspaciadoAgroVision.md),
                  Opacity(
                    opacity: opacidadFormulario,
                    child: Transform.translate(
                      offset: Offset(0, (1 - opacidadFormulario) * EspaciadoAgroVision.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Activá tu AgroVision',
                            textAlign: TextAlign.center,
                            style: textos.headlineMedium,
                          ),
                          const SizedBox(height: EspaciadoAgroVision.lg),
                          TextField(
                            controller: _clave,
                            enabled: !cargando && !exito,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _activar(),
                            decoration: const InputDecoration(
                              labelText: 'Clave de licencia',
                            ),
                          ),
                          SizedBox(
                            height: EspaciadoAgroVision.alturaSlotError,
                            child: Center(
                              child: Opacity(
                                opacity: tError,
                                child: Transform.translate(
                                  offset: Offset(0, (tError - 1) * EspaciadoAgroVision.sm),
                                  child: Text(
                                    _mensajeError,
                                    textAlign: TextAlign.center,
                                    style: textos.bodySmall?.copyWith(color: colores.error),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: opacidadBoton,
                    child: SizedBox(
                      height: EspaciadoAgroVision.alturaBoton,
                      child: ElevatedButton(
                        onPressed: cargando || exito ? null : _activar,
                        style: ElevatedButton.styleFrom(
                          disabledBackgroundColor: colores.primary,
                          disabledForegroundColor: colores.onPrimary,
                        ),
                        child: cargando
                            ? SizedBox(
                                width: EspaciadoAgroVision.indicadorCarga,
                                height: EspaciadoAgroVision.indicadorCarga,
                                child: CircularProgressIndicator(
                                  strokeWidth: EspaciadoAgroVision.grosorIndicador,
                                  color: colores.onPrimary,
                                ),
                              )
                            : exito
                                ? Transform.scale(
                                    scale: tCheck,
                                    child: const Icon(
                                      Icons.check,
                                      size: EspaciadoAgroVision.iconoCheck,
                                    ),
                                  )
                                : const Text('Activar'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Progreso de un tramo de la animación: 0 antes de [inicio], 1 después de [fin].
double _tramo(double valor, double inicio, double fin) {
  return ((valor - inicio) / (fin - inicio)).clamp(0.0, 1.0).toDouble();
}

double _positivo(double valor) => valor < 0 ? 0 : valor;
