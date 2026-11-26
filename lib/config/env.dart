import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Leitura centralizada das variáveis de ambiente do arquivo `.env`.
abstract final class Env {
  static const String supabaseUrlKey = 'SUPABASE_URL';
  static const String supabaseAnonKeyKey = 'SUPABASE_ANON_KEY';

  static Future<void> load() => dotenv.load(fileName: '.env');

  /// Retorna o valor configurado ou `null` quando está vazio/placeholder.
  static String? value(String key) {
    final String? raw = dotenv.env[key]?.trim();
    if (raw == null || raw.isEmpty || _isPlaceholder(raw)) {
      return null;
    }
    return raw;
  }

  static bool get isSupabaseConfigured =>
      value(supabaseUrlKey) != null && value(supabaseAnonKeyKey) != null;

  static String get supabaseUrl =>
      value(supabaseUrlKey) ?? _missing(supabaseUrlKey);

  static String get supabaseAnonKey =>
      value(supabaseAnonKeyKey) ?? _missing(supabaseAnonKeyKey);

  static bool _isPlaceholder(String value) =>
      value.contains('seu-projeto') || value.contains('sua-chave-anon-aqui');

  static Never _missing(String key) =>
      throw StateError('Variável $key não configurada no arquivo .env.');
}
