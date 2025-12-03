import 'dart:io';
import 'package:flutter/material.dart';
import '../../shared/models/collection.dart';
import 'item_form_page.dart';
import '../../shared/models/item.dart';
import '../../shared/repository/item_repository.dart';
import '../../core/logs/logger.dart';

class ItemDetailPage extends StatelessWidget {
  final Item item;
  final Collection? collection;

  const ItemDetailPage({super.key, required this.item, this.collection});

  Future<void> _confirmAndDelete(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmação'),
        content: const Text('Excluir este item? Esta ação não pode ser desfeita.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Excluir')),
        ],
      ),
    );
    if (ok != true) return;

    final repo = ItemRepository();
    await repo.delete(item.id!);
    AppLogger.i('Item deleted from detail: ${item.id}');
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        actions: [
          if (collection != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => ItemFormPage(collection: collection!, createdAt: item.createdAt, item: item)));
                if (result == true) Navigator.of(context).pop(true);
              },
            ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _confirmAndDelete(context),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (item.imagePath != null) ...[
            SizedBox(
              height: 260,
              child: Image.file(File(item.imagePath!), fit: BoxFit.cover),
            ),
            const SizedBox(height: 12),
          ],
          Text(item.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(item.description ?? '', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 12),
          Text('Criado em: ${item.createdAt}', style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
