import 'package:flutter_test/flutter_test.dart';

import 'package:geofield/app.dart';

void main() {
  // Com kDevBypassAuth == true, o app abre direto na MainShell. Ao desligar a
  // flag em lib/config/dev_flags.dart, este teste deve voltar a verificar o
  // LoginScreen ("Bem-vindo de volta") quando não há sessão.
  testWidgets('GeoField abre na MainShell com o bypass de desenvolvimento',
      (tester) async {
    await tester.pumpWidget(const GeoFieldApp());
    await tester.pumpAndSettle();

    expect(find.text('Início'), findsOneWidget);
    expect(find.text('Levantamentos'), findsOneWidget);
    expect(find.text('Perfil'), findsOneWidget);
    expect(find.text('Acesso rápido'), findsOneWidget);
    expect(find.text('Bem-vindo de volta'), findsNothing);
  });
}
