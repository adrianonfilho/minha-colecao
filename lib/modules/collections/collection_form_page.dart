import 'package:flutter/material.dart';
import '../../shared/repository/collection_repository.dart';
import '../../shared/models/collection.dart';
import '../../core/logs/logger.dart';

class CollectionFormPage extends StatefulWidget {
  final String createdAt;
  const CollectionFormPage({super.key, required this.createdAt});

  @override
  State<CollectionFormPage> createState() => _CollectionFormPageState();
}

class _CollectionFormPageState extends State<CollectionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final repo = CollectionRepository();

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final c = Collection(name: _nameCtrl.text.trim(), createdAt: widget.createdAt);
    await repo.insert(c);
    AppLogger.i('Collection created: ${c.name}');
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Coleção'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Nome da coleção'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Informe um nome' : null,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _save,
                child: const Text('Salvar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
