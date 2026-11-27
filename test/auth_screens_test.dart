import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:geofield/screens/auth/forgot_password_screen.dart';
import 'package:geofield/screens/auth/register_screen.dart';
import 'package:geofield/services/auth_service.dart';

void main() {
  testWidgets(
    'RegisterScreen exibe título, campos e botão de cadastro',
    (tester) async {
      final AuthService authService = AuthService();
      addTearDown(authService.dispose);

      await tester.pumpWidget(
        MaterialApp(home: RegisterScreen(authService: authService)),
      );

      // O título e o botão usam o mesmo texto.
      expect(find.text('Criar conta'), findsNWidgets(2));
      expect(find.text('Nome completo'), findsOneWidget);
      expect(find.text('Confirmar senha'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.byType(FilledButton), findsOneWidget);
    },
  );

  testWidgets(
    'ForgotPasswordScreen exibe título, campo de e-mail e botão de envio',
    (tester) async {
      final AuthService authService = AuthService();
      addTearDown(authService.dispose);

      await tester.pumpWidget(
        MaterialApp(home: ForgotPasswordScreen(authService: authService)),
      );

      expect(find.text('Recuperar senha'), findsOneWidget);
      expect(find.text('E-mail'), findsOneWidget);
      expect(find.text('Enviar link de recuperação'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(FilledButton), findsOneWidget);
    },
  );
}
