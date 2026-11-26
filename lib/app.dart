import 'package:material_ui/material_ui.dart';

import 'screens/auth/auth_gate.dart';

/// Widget raiz do GeoField: tema Material 3 e ponto único de roteamento.
class GeoFieldApp extends StatelessWidget {
  const GeoFieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeoField',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B6E4A)),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      home: const AuthGate(),
    );
  }
}
