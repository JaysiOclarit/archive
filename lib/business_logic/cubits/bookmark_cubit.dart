import 'package:archive/data/models/bookmark_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:archive/data/repositories/bookmark_repository.dart';
import 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  // The Cubit needs the Repository to get the data
  final BookmarkRepository _repository;

  BookmarkCubit({required BookmarkRepository repository})
    : _repository = repository,
      super(BookmarkInitial());

  /// 1. READ: Fetches all bookmarks
  Future<void> loadBookmarks() async {
    try {
      emit(BookmarkLoading());
      final bookmarks = await _repository.getAllBookmarks();
      emit(BookmarkLoaded(bookmarks));
    } catch (e) {
      emit(BookmarkError(e.toString()));
    }
  }

  /// Fetches bookmarks specifically for one folder
  Future<void> loadBookmarksForFolder(String folderId) async {
    try {
      // 1. Tell the UI to show a loading spinner
      emit(BookmarkLoading());

      // 2. Ask the repository for the specific folder's bookmarks
      final bookmarks = await _repository.getBookmarksByFolderId(folderId);

      // 3. Tell the UI to show the filtered list!
      emit(BookmarkLoaded(bookmarks));
    } catch (e) {
      emit(BookmarkError(e.toString()));
    }
  }

  /// 2. CREATE: Adds a new bookmark
  Future<void> addBookmark(Bookmark newBookmark) async {
    try {
      await _repository.saveBookmark(newBookmark);
      await loadBookmarks(); // Refresh the list
    } catch (e) {
      emit(BookmarkError('Failed to save bookmark: $e'));
    }
  }

  /// 3. UPDATE: Edits an existing bookmark (like changing the URL or Title)
  Future<void> updateBookmark(Bookmark updatedBookmark) async {
    try {
      // Same magic as Collections: save handles updates too!
      await _repository.saveBookmark(updatedBookmark);
      await loadBookmarks();
    } catch (e) {
      emit(BookmarkError('Failed to update bookmark: $e'));
    }
  }

  /// 4. DELETE: Removes a bookmark by its ID
  Future<void> deleteBookmark(String id) async {
    try {
      await _repository.deleteBookmark(id);
      await loadBookmarks();
    } catch (e) {
      emit(BookmarkError('Failed to delete bookmark: $e'));
    }
  }
}
