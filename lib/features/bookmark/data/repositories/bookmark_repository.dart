// lib/data/repositories/bookmark_repository.dart

import 'package:archive/features/bookmark/data/datasources/bookmark_data_provider.dart';
import 'package:archive/features/bookmark/data/models/bookmark_model.dart';

class BookmarkRepository {
  // The repository needs the provider to do the actual fetching.
  // Notice we use the Interface (IBookmarkDataProvider), not the Mock class!
  // This makes swapping to a real database later incredibly easy.
  final IBookmarkDataProvider _dataProvider;

  BookmarkRepository({required IBookmarkDataProvider dataProvider})
    : _dataProvider = dataProvider;

  /// Fetches raw maps from the provider and converts them into a List of Bookmarks
  Future<List<Bookmark>> getAllBookmarks() async {
    try {
      // 1. Get the raw data
      final rawData = await _dataProvider.getRawBookmarks();

      // 2. Map over the list, converting each Map into a Bookmark object
      // using the factory you built earlier.
      return rawData.map((map) => Bookmark.fromMap(map)).toList();
    } catch (e) {
      // In a real app, you might log this error to a crashlytics service
      // For now, we just throw it so the BLoC can show an error screen
      throw Exception('Failed to fetch bookmarks: $e');
    }
  }

  /// Fetches only the bookmarks that belong to a specific collection
  Future<List<Bookmark>> getBookmarksByFolderId(String folderId) async {
    try {
      // 1. Ask the provider for the filtered raw data
      final rawData = await _dataProvider.getRawBookmarksByFolder(folderId);

      // 2. Translate those maps into Bookmark objects
      return rawData.map((map) => Bookmark.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to load folder bookmarks: $e');
    }
  }

  /// Converts a Bookmark object into a Map and tells the provider to save it
  Future<void> saveBookmark(Bookmark bookmark) async {
    try {
      // Use the toMap() method you wrote to turn the object back into JSON
      final rawMap = bookmark.toMap();
      await _dataProvider.saveRawBookmark(rawMap);
    } catch (e) {
      throw Exception('Failed to save bookmark: $e');
    }
  }

  /// Tells the provider to delete a bookmark by its ID
  Future<void> deleteBookmark(String id) async {
    try {
      await _dataProvider.deleteBookmark(id);
    } catch (e) {
      throw Exception('Failed to delete bookmark: $e');
    }
  }
}
