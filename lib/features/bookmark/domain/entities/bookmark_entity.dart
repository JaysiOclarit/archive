import 'package:equatable/equatable.dart';

class BookmarkEntity extends Equatable {
  final String id;
  final String url;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime createdAt;
  final String? folderId;
  final List<String> tags;

  const BookmarkEntity({
    required this.id,
    required this.url,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    this.folderId,
    this.tags = const [],
  });

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
}
