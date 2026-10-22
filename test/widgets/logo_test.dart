import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agrovision_mobile/widgets/logo.dart';

void main() {
  testWidgets('el logo se dibuja con la altura pedida y respeta la proporción 280x235', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Center(child: LogoAgroVision(altura: 47))),
      ),
    );

    final tamano = tester.getSize(find.byType(LogoAgroVision));
    expect(tamano.height, 47);
    expect(tamano.width, closeTo(47 * 280 / 235, 0.01));
  });
}
