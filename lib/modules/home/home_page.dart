import 'package:flutter/material.dart';
import '../collections/collections_page.dart';
import '../settings/settings_page.dart';
import '../../core/logs/logger.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppLogger.i('Open HomePage');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Coleção'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Minha Coleção')),
            ListTile(
              leading: const Icon(Icons.collections),
              title: const Text('Coleções'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CollectionsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsPage()));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.collections_bookmark),
          label: const Text('Ver minhas coleções'),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CollectionsPage()));
          },
        ),
      ),
    );
  }
}
