import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/models/collection.dart';
import '../../shared/models/item.dart';
import '../../shared/repository/item_repository.dart';
import '../../core/logs/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ItemFormPage extends StatefulWidget {
  final Collection collection;
  final String? createdAt;
  final Item? item;

  const ItemFormPage({super.key, required this.collection, this.createdAt, this.item});

  @override
  State<ItemFormPage> createState() => _ItemFormPageState();
}

class _ItemFormPageState extends State<ItemFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final repo = ItemRepository();
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _titleCtrl.text = widget.item!.title;
      _descCtrl.text = widget.item!.description ?? '';
      _imagePath = widget.item!.imagePath;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.camera, maxWidth: 1024);
    if (file == null) return;

    // copy to app dir
    final appDoc = await getApplicationDocumentsDirectory();
    final fileName = path.basename(file.path);
    final saved = await File(file.path).copy('${appDoc.path}/$fileName');
    setState(() {
      _imagePath = saved.path;
    });
    AppLogger.i('Image saved: $_imagePath');
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery, maxWidth: 1024);
    if (file == null) return;

    // copy to app dir
    final appDoc = await getApplicationDocumentsDirectory();
    final fileName = path.basename(file.path);
    final saved = await File(file.path).copy('${appDoc.path}/$fileName');
    setState(() {
      _imagePath = saved.path;
    });
    AppLogger.i('Image saved: $_imagePath');
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final createdAt = widget.item?.createdAt ?? widget.createdAt ?? DateTime.now().toIso8601String();
    if (widget.item != null && widget.item!.id != null) {
      final updated = Item(
        id: widget.item!.id,
        collectionId: widget.collection.id!,
        title: _titleCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        imagePath: _imagePath,
        createdAt: createdAt,
      );
      await repo.update(updated);
      AppLogger.i('Item updated: ${updated.title}');
      Navigator.of(context).pop(true);
      return;
    }

    final item = Item(
      collectionId: widget.collection.id!,
      title: _titleCtrl.text.trim(),
      description: _descCtrl.text.trim(),
      imagePath: _imagePath,
      createdAt: createdAt,
    );
    await repo.insert(item);
    AppLogger.i('Item created: ${item.title}');
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item != null ? 'Editar Item' : 'Novo Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Informe um título' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              if (_imagePath != null) Image.file(File(_imagePath!)),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Tirar Foto'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () => _pickImageFromGallery(),
                    icon: const Icon(Icons.photo),
                    label: const Text('Galeria'),
                  ),
                  const SizedBox(width: 12),
                  if (_imagePath != null)
                    TextButton(
                      onPressed: () => setState(() => _imagePath = null),
                      child: const Text('Remover'),
                    )
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _save, child: const Text('Salvar Item')),
            ],
          ),
        ),
      ),
    );
  }
}
