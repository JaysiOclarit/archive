import 'package:archive/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    super.title,
    super.bio,
  });

  @override
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? title,
    String? bio,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      title: title ?? this.title,
      bio: bio ?? this.bio,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      id: documentId,
      email: map['email'] ?? '',
      name: map['name'] ?? 'Unknown Curator',
      title: map['title'],
      bio: map['bio'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      if (title != null) 'title': title,
      if (bio != null) 'bio': bio,
    };
  }

  UserEntity toEntity() => this;
}
