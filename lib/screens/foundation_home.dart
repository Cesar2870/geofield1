import 'package:material_ui/material_ui.dart';

import '../config/supabase_config.dart';
import '../widgets/connectivity_state.dart';

/// Tela temporária da Etapa 2: confirma a fundação sem inventar funcionalidades.
class FoundationHome extends StatelessWidget {
  const FoundationHome({super.key});

  @override
  Widget build(BuildContext context) {
    final String supabaseStatus = SupabaseConfig.isReady
        ? 'Inicializado com as credenciais do .env.'
        : SupabaseConfig.error ?? 'Não inicializado nesta sessão.';

    return Scaffold(
      appBar: AppBar(
        title: const Text('GeoField'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: ConnectivityState(
          builder: (context, connectivity) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Etapa 2 - Fundação',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Estrutura offline-first pronta: configuração, banco local, '
                            'modelos sincronizáveis e detecção de conectividade.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _StatusTile(
                    icon: SupabaseConfig.isReady ? Icons.cloud_done : Icons.cloud_off,
                    title: 'Supabase',
                    subtitle: supabaseStatus,
                  ),
                  _StatusTile(
                    icon: connectivity.isOnline ? Icons.wifi : Icons.wifi_off,
                    title: 'Conectividade',
                    subtitle: 'Estado atual: ${connectivity.label}.',
                  ),
                  const SizedBox(height: 12),
                  Card(
                    color: Theme.of(context).colorScheme.errorContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.warning,
                            color: Theme.of(context).colorScheme.onErrorContainer,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Aviso de precisão: coordenadas de GPS de smartphone '
                              'não são topograficamente precisas. A precisão depende '
                              'do dispositivo, do ambiente e do sinal GNSS.',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StatusTile extends StatelessWidget {
  const _StatusTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
