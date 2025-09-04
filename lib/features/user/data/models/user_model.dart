import 'package:mood_log_tests/features/user/domain/entity/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.name, required super.createdAt});

  factory UserModel.fromEntity(User user) {
    return UserModel(id: user.id, name: user.name, createdAt: user.createdAt);
  }

  User toEntity() {
    return User(id: id, name: name, createdAt: createdAt);
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "created_at": createdAt?.toIso8601String(),
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
  );
}
