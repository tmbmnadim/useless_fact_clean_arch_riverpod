class User {
  final String? id;
  final String? name;
  final DateTime? createdAt;

  User({required this.id, required this.name, required this.createdAt});

  User copyWith({String? id, String? name, DateTime? createdAt}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
