import 'dart:io';
import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;

  const ItemCard({super.key, required this.item, this.onDelete, this.onTap, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: item.imagePath != null ? Image.file(File(item.imagePath!)) : const Icon(Icons.image_not_supported),
        title: Text(item.title),
        subtitle: Text(item.description ?? ''),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
            IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}
