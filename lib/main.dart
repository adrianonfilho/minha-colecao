import 'package:flutter/material.dart';
import 'app.dart';
import 'core/theme/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeService.instance.init();
  runApp(const MyApp());
}
