class User {
  final int? id;
  final String? name;
  final DateTime? createdAt;

  User({this.id, this.name, this.createdAt});

  User copyWith({int? id, String? name, DateTime? createdAt}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
