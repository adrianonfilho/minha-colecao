class Item {
  final int? id;
  final int collectionId;
  final String title;
  final String? description;
  final String? imagePath;
  final String createdAt;

  Item({
    this.id,
    required this.collectionId,
    required this.title,
    this.description,
    this.imagePath,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'collection_id': collectionId,
      'title': title,
      'description': description,
      'image_path': imagePath,
      'created_at': createdAt,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as int?,
      collectionId: map['collection_id'] as int,
      title: map['title'] as String,
      description: map['description'] as String?,
      imagePath: map['image_path'] as String?,
      createdAt: map['created_at'] as String,
    );
  }
}
