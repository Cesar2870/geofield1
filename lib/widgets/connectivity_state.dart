import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:material_ui/material_ui.dart';

/// Estado de conectividade usado pela UI para avisar quando o app está offline.
enum ConnectivityStatus {
  online,
  offline;

  bool get isOnline => this == ConnectivityStatus.online;

  String get label => isOnline ? 'Online' : 'Offline';
}

/// Detecta mudanças de rede com `connectivity_plus` e repassa o estado ao builder.
class ConnectivityState extends StatefulWidget {
  const ConnectivityState({super.key, required this.builder});

  final Widget Function(BuildContext context, ConnectivityStatus status) builder;

  @override
  State<ConnectivityState> createState() => _ConnectivityStateState();
}

class _ConnectivityStateState extends State<ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  ConnectivityStatus _status = ConnectivityStatus.online;

  @override
  void initState() {
    super.initState();
    _refresh();
    _subscription = _connectivity.onConnectivityChanged.listen(
      _handleResults,
      onError: (Object _) => _setStatus(ConnectivityStatus.offline),
    );
  }

  Future<void> _refresh() async {
    try {
      final List<ConnectivityResult> results =
          await _connectivity.checkConnectivity();
      _handleResults(results);
    } on Object {
      // Em testes sem canal nativo, mantemos o estado conservador.
      _setStatus(ConnectivityStatus.offline);
    }
  }

  void _handleResults(List<ConnectivityResult> results) {
    final bool hasNetwork = results.any((r) => r != ConnectivityResult.none);
    _setStatus(hasNetwork ? ConnectivityStatus.online : ConnectivityStatus.offline);
  }

  void _setStatus(ConnectivityStatus status) {
    if (!mounted || status == _status) return;
    setState(() => _status = status);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _status);
}
