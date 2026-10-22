import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agrovision_mobile/core/theme/colores.dart';
import 'package:agrovision_mobile/core/theme/tema.dart';
import 'package:agrovision_mobile/core/theme/tipografia.dart';

void main() {
  group('colores de marca', () {
    test('el azul principal es #1E6FFF', () {
      expect(ColoresAgroVision.azul, const Color(0xFF1E6FFF));
    });

    test('el terra del logo es #E05A2B', () {
      expect(ColoresAgroVision.terra, const Color(0xFFE05A2B));
    });

    test('el tema claro usa el azul de marca como primario', () {
      expect(TemaAgroVision.claro().colorScheme.primary, ColoresAgroVision.azul);
    });

    test('el tema oscuro usa el azul de marca como primario', () {
      expect(TemaAgroVision.oscuro().colorScheme.primary, ColoresAgroVision.azul);
    });

    test('el tema claro no usa el terra como color de interfaz', () {
      final esquema = TemaAgroVision.claro().colorScheme;
      final colores = [esquema.primary, esquema.secondary, esquema.surface, esquema.outline];
      expect(colores, isNot(contains(ColoresAgroVision.terra)));
    });
  });

  group('temas', () {
    test('el tema claro es claro y el oscuro es oscuro', () {
      expect(TemaAgroVision.claro().brightness, Brightness.light);
      expect(TemaAgroVision.oscuro().brightness, Brightness.dark);
    });

    test('ambos temas se construyen sin error y usan Material 3', () {
      expect(() => TemaAgroVision.claro(), returnsNormally);
      expect(() => TemaAgroVision.oscuro(), returnsNormally);
      expect(TemaAgroVision.claro().useMaterial3, isTrue);
      expect(TemaAgroVision.oscuro().useMaterial3, isTrue);
    });

    test('los títulos usan Rajdhani y el texto usa Inter', () {
      final tema = TemaAgroVision.claro();
      expect(tema.textTheme.headlineMedium?.fontFamily, TipografiaAgroVision.familiaTitulos);
      expect(tema.textTheme.bodyMedium?.fontFamily, TipografiaAgroVision.familiaTexto);
    });

    test('el fondo del tema oscuro es navy de marca', () {
      expect(TemaAgroVision.oscuro().scaffoldBackgroundColor, ColoresAgroVision.navy);
    });
  });
}
