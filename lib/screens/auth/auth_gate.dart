import 'dart:async';

import 'package:material_ui/material_ui.dart';

import '../../config/dev_flags.dart';
import '../../services/auth_service.dart';
import '../main_shell.dart';
import 'login_screen.dart';

/// Decide entre login e navegação principal a partir do estado do Supabase.
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late final AuthService _authService;
  StreamSubscription<AuthStatus>? _subscription;

  /// `null` enquanto a primeira resolução do estado não acontece.
  AuthStatus? _status;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
    _subscription = _authService.onAuthStateChange.listen((status) {
      if (!mounted) return;
      setState(() => _status = status);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() => _status = _authService.currentStatus);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    unawaited(_authService.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Bypass de desenvolvimento (kDevBypassAuth); remover/desligar quando o
    // Supabase estiver configurado.
    if (kDevBypassAuth) {
      return const MainShell();
    }

    final AuthStatus? status = _status;
    if (status == null) {
      return const Scaffold(
        backgroundColor: Color(0xFFF7F7F2),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF18583D)),
        ),
      );
    }

    switch (status) {
      case AuthStatus.authenticated:
        return const MainShell();
      case AuthStatus.unauthenticated:
        return LoginScreen(authService: _authService);
    }
  }
}
