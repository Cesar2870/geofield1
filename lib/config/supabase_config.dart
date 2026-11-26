import 'package:supabase_flutter/supabase_flutter.dart';

import 'env.dart';

/// Inicialização única do Supabase a partir do `.env` local.
abstract final class SupabaseConfig {
  static bool _initialized = false;
  static String? _error;

  static bool get isReady => _initialized;
  static String? get error => _error;

  static Future<void> initialize() async {
    if (_initialized) return;

    if (!Env.isSupabaseConfigured) {
      _error = 'Preencha SUPABASE_URL e SUPABASE_ANON_KEY no arquivo .env.';
      return;
    }

    try {
      await Supabase.initialize(
        url: Env.supabaseUrl,
        publishableKey: Env.supabaseAnonKey,
      );
      _initialized = true;
      _error = null;
    } catch (e) {
      _initialized = false;
      _error = 'Não foi possível inicializar o Supabase: $e';
    }
  }

  /// Cliente para uso nas camadas de dados e sincronização.
  static SupabaseClient get client {
    if (!_initialized) {
      throw StateError('Supabase não foi inicializado. Verifique o arquivo .env.');
    }
    return Supabase.instance.client;
  }
}
