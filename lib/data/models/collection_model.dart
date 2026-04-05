import 'package:archive/data/models/bookmark_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Collection extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String notes;
  final int iconCodePoint;
  final String? iconFontFamily;
  final List<Bookmark> bookmarks;
  final DateTime createdAt;

  const Collection({
    required this.id,
    required this.userId,
    required this.name,
    this.notes = '',
    required this.iconCodePoint,
    this.iconFontFamily,
    required this.bookmarks,
    required this.createdAt,
  });

  // A helper getter to turn the saved integers back into a usable Flutter Icon
  IconData get icon =>
      IconData(iconCodePoint, fontFamily: iconFontFamily ?? 'MaterialIcons');

  // 1. Equatable: List all properties that determine if a bookmark is "the same"
  @override
  List<Object?> get props => [
    id,
    name,
    notes,
    iconCodePoint,
    iconFontFamily,
    bookmarks,
    createdAt,
  ];

  // 2. copyWith: Used when a user edits a collection
  Collection copyWith({
    String? name,
    String? notes,
    int? iconCodePoint,
    String? iconFontFamily,
    List<Bookmark>? bookmarks,
    DateTime? createdAt,
  }) {
    return Collection(
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

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      name: map['name'] ?? 'Untitled Collection',
      notes: map['notes'] ?? '',
      iconCodePoint: map['iconCodePoint'] ?? 0xe2af,
      iconFontFamily: map['iconFontFamily'],
      // Map through the list of raw data and convert each Map into a Bookmark object
      bookmarks:
          (map['bookmarks'] as List<dynamic>?)
              ?.map((x) => Bookmark.fromMap(x as Map<String, dynamic>))
              .toList() ??
          [],
      // Parse the String from the database into a real DateTime object
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
      'bookmarks': bookmarks.map((b) => b.toMap()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
