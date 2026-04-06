import 'package:equatable/equatable.dart';

/// Domain entity representing a user/curator.
///
/// This is a pure Dart object (no JSON or Flutter dependencies) used by the
/// domain and presentation layers. Fields are immutable and value equality is
/// provided by `Equatable`.
class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? title;
  final String? bio;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.title,
    this.bio,
  });

  UserEntity copyWith({
    String? id,
    String? email,
    String? name,
    String? title,
    String? bio,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      title: title ?? this.title,
      bio: bio ?? this.bio,
    );
  }

  @override
  List<Object?> get props => [id, email, name, title, bio];
}
