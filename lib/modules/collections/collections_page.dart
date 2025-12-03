import 'package:flutter/material.dart';
import '../../shared/repository/collection_repository.dart';
import '../../shared/models/collection.dart';
import '../../shared/widgets/collection_card.dart';
import 'collection_form_page.dart';
import '../items/items_page.dart';
import '../../core/logs/logger.dart';
import 'package:intl/intl.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  final repo = CollectionRepository();
  List<Collection> _items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final all = await repo.getAll();
    setState(() => _items = all);
  }

  Future<void> _delete(int id) async {
    await repo.delete(id);
    AppLogger.i('Collection deleted: $id');
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coleções'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final c = _items[index];
          return CollectionCard(
            collection: c,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => ItemsPage(collection: c)));
            },
            onDelete: () => _delete(c.id!),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final createdAt = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
          final result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => CollectionFormPage(createdAt: createdAt)));
          if (result == true) _load();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
