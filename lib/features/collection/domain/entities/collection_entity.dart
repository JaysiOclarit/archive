import 'package:archive/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:equatable/equatable.dart';

class CollectionEntity extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String notes;
  final int iconCodePoint;
  final String? iconFontFamily;
  final List<BookmarkEntity> bookmarks;
  final DateTime createdAt;

  const CollectionEntity({
    required this.id,
    required this.userId,
    required this.name,
    this.notes = '',
    required this.iconCodePoint,
    this.iconFontFamily,
    required this.bookmarks,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    name,
    notes,
    iconCodePoint,
    iconFontFamily,
    bookmarks,
    createdAt,
  ];
}
