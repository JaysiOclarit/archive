import 'package:archive/features/collection/domain/entities/collection_entity.dart';
import 'package:archive/features/bookmark/data/models/bookmark_model.dart';

class CollectionModel extends CollectionEntity {
  const CollectionModel({
    required super.id,
    required super.userId,
    required super.name,
    super.notes = '',
    required super.iconCodePoint,
    super.iconFontFamily,
    required super.bookmarks, // List<BookmarkEntity> but we will pass BookmarkModel inside
    required super.createdAt,
  });

  CollectionModel copyWith({
    String? name,
    String? notes,
    int? iconCodePoint,
    String? iconFontFamily,
    List<BookmarkModel>? bookmarks,
    DateTime? createdAt,
  }) {
    return CollectionModel(
      id: id,
      userId: userId,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      iconFontFamily: iconFontFamily ?? this.iconFontFamily,
      bookmarks: bookmarks ?? this.bookmarks,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory CollectionModel.fromMap(Map<String, dynamic> map) {
    return CollectionModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      name: map['name'] ?? 'Untitled Collection',
      notes: map['notes'] ?? '',
      iconCodePoint: map['iconCodePoint'] ?? 0xe2af,
      iconFontFamily: map['iconFontFamily'],
      bookmarks:
          (map['bookmarks'] as List<dynamic>?)
              ?.map((x) => BookmarkModel.fromMap(x as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'notes': notes,
      'iconCodePoint': iconCodePoint,
      'iconFontFamily': iconFontFamily,
      'bookmarks': bookmarks.map((b) => (b as BookmarkModel).toMap()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  CollectionEntity toEntity() {
    return CollectionEntity(
      id: id,
      userId: userId,
      name: name,
      notes: notes,
      iconCodePoint: iconCodePoint,
      iconFontFamily: iconFontFamily,
      bookmarks: bookmarks.map((b) => (b as BookmarkModel).toEntity()).toList(),
      createdAt: createdAt,
    );
  }
}
