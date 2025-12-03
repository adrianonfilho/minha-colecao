import 'package:flutter/material.dart';
import '../../core/logs/logger.dart';
import '../../core/theme/theme_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    AppLogger.i('Open Settings');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Tema do aplicativo', style: Theme.of(context).textTheme.titleMedium),
          ),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: ThemeService.instance.themeMode,
            builder: (context, mode, _) {
              return Column(
                children: [
                  RadioListTile<ThemeMode>(
                    title: const Text('Usar tema do sistema'),
                    value: ThemeMode.system,
                    groupValue: mode,
                    onChanged: (v) => ThemeService.instance.setThemeMode(v ?? ThemeMode.system),
                  ),
                  RadioListTile<ThemeMode>(
                    title: const Text('Claro'),
                    value: ThemeMode.light,
                    groupValue: mode,
                    onChanged: (v) => ThemeService.instance.setThemeMode(v ?? ThemeMode.light),
                  ),
                  RadioListTile<ThemeMode>(
                    title: const Text('Escuro'),
                    value: ThemeMode.dark,
                    groupValue: mode,
                    onChanged: (v) => ThemeService.instance.setThemeMode(v ?? ThemeMode.dark),
                  ),
                ],
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Sobre'),
            subtitle: const Text('Minha Coleção - Aplicativo de gerenciamento de coleções. Feito para matéria de Desenvolvimento de Sistemas para Dispositivos Móveis.'),
          ),
        ],
      ),
    );
  }
}
