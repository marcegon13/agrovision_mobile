import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agrovision_mobile/main.dart';

void main() {
  testWidgets('la app arranca en la pantalla de activación', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: AgroVisionApp()));

    expect(find.text('Activá tu AgroVision'), findsOneWidget);
    expect(find.text('Activar'), findsOneWidget);
  });
}
