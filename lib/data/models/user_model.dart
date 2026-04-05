class UserModel {
  final String id;
  final String email;
  final String name;
  final String? title;
  final String? bio;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.title,
    this.bio,
  });

  // The copyWith method
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? title,
    String? bio,
  }) {
    return UserModel(
      // If a new 'id' is passed, use it. Otherwise, use the existing 'this.id'
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
  // To save it back to Firestore
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      // Only add these to the database if they actually exist!
      if (title != null) 'title': title,
      if (bio != null) 'bio': bio,
    };
  }

  @override
  List<Object?> get props => [id, email, name, title, bio];
}
