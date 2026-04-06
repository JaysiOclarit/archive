import 'package:archive/features/bookmark/domain/entities/bookmark_entity.dart';

class BookmarkModel extends BookmarkEntity {
  const BookmarkModel({
    required super.id,
    required super.url,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.createdAt,
    super.folderId,
    super.tags = const [],
  });

  BookmarkModel copyWith({
    String? title,
    String? description,
    String? folderId,
    List<String>? tags,
    DateTime? createdAt,
  }) {
    return BookmarkModel(
      id: id,
      url: url,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl,
      createdAt: createdAt ?? this.createdAt,
      folderId: folderId ?? this.folderId,
      tags: tags ?? this.tags,
    );
  }

  factory BookmarkModel.fromMap(Map<String, dynamic> map) {
    return BookmarkModel(
      id: map['id'] ?? '',
      url: map['url'] ?? '',
      title: map['title'] ?? 'Untitled',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      folderId: map['folderId'],
      tags: map['tags'] != null ? List<String>.from(map['tags']) : const [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'folderId': folderId,
      'tags': tags,
    };
  }

  BookmarkEntity toEntity() {
    return BookmarkEntity(
      id: id,
      url: url,
      title: title,
      description: description,
      imageUrl: imageUrl,
      createdAt: createdAt,
      folderId: folderId,
      tags: tags,
    );
  }
}
