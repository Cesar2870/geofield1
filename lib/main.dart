import 'package:flutter/widgets.dart';

import 'app.dart';
import 'config/env.dart';
import 'config/supabase_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Env.load();
  await SupabaseConfig.initialize();

  runApp(const GeoFieldApp());
}
