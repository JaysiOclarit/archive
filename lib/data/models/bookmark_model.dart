import 'package:equatable/equatable.dart';

class Bookmark extends Equatable {
  final String id;
  final String url;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime createdAt;
  final String? folderId;
  final List<String> tags;

  const Bookmark({
    required this.id,
    required this.url,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    this.folderId,
    this.tags = const [],
  });

  // 1. Equatable: List all properties that determine if a bookmark is "the same"
  @override
  List<Object?> get props => [
    id,
    url,
    title,
    description,
    imageUrl,
    createdAt,
    folderId,
    tags,
  ];

  // 2. copyWith: Used when a user edits a bookmark or adds a tag
  Bookmark copyWith({
    String? title,
    String? description,
    String? folderId,
    List<String>? tags,
    DateTime? createdAt,
  }) {
    return Bookmark(
      id: id, // ID and URL usually never change
      url: url,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl,
      createdAt: createdAt ?? this.createdAt,
      folderId: folderId ?? this.folderId,
      tags: tags ?? this.tags,
    );
  }

  // 3. fromJson: Used by your Repository to parse data from the web
  factory Bookmark.fromMap(Map<String, dynamic> map) {
    return Bookmark(
      id: map['id'] ?? '',
      url: map['url'] ?? '',
      title: map['title'] ?? 'Untitled',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      // Parse the String from the database into a real DateTime object
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      folderId: map['folderId'],
      tags: map['tags'] != null ? List<String>.from(map['tags']) : const [],
    );
  }

  // 4. toMap: Used to save data back to your database or API
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(), // Converts Date back to String
      'folderId': folderId,
      'tags': tags,
    };
  }
}
