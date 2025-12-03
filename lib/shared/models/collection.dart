class Collection {
  final int? id;
  final String name;
  final String createdAt;

  Collection({this.id, required this.name, required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
    };
  }

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      id: map['id'] as int?,
      name: map['name'] as String,
      createdAt: map['created_at'] as String,
    );
  }
}
