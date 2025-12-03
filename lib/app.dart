import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'modules/home/home_page.dart';
import 'core/logs/logger.dart';
import 'core/theme/theme_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppLogger.init();
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeService.instance.themeMode,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'Minha Coleção',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: mode,
          home: const HomePage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
