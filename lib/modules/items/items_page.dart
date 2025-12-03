import 'package:flutter/material.dart';
import '../../shared/models/collection.dart';
import '../../shared/repository/item_repository.dart';
import '../../shared/widgets/item_card.dart';
import '../../shared/models/item.dart';
import 'item_form_page.dart';
import 'item_detail_page.dart';
import '../../core/logs/logger.dart';

class ItemsPage extends StatefulWidget {
  final Collection collection;
  const ItemsPage({super.key, required this.collection});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  final repo = ItemRepository();
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final all = await repo.getByCollection(widget.collection.id!);
    setState(() => items = all);
  }

  Future<void> _delete(int id) async {
    await repo.delete(id);
    AppLogger.i('Item deleted: $id');
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Itens: ${widget.collection.name}'),
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: items.isEmpty
            ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: 60),
                  Center(child: Text('Nenhum item nesta coleção. Use o botão + para adicionar.')),
                ],
              )
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final it = items[index];
                          return ItemCard(
                            item: it,
                            onDelete: () => _delete(it.id!),
                            onEdit: () async {
                              final result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => ItemFormPage(collection: widget.collection, createdAt: it.createdAt, item: it)));
                              if (result == true) await _load();
                            },
                            onTap: () async {
                              final result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => ItemDetailPage(item: it, collection: widget.collection)));
                              if (result == true) await _load();
                            },
                          );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final createdAt = DateTime.now().toIso8601String();
          final result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ItemFormPage(collection: widget.collection, createdAt: createdAt),
          ));
          if (result == true) _load();
        },
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
