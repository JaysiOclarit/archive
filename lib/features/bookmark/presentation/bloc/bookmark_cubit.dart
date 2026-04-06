import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:archive/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:archive/features/bookmark/domain/usecases/get_all_bookmarks.dart';
import 'package:archive/features/bookmark/domain/usecases/get_bookmarks_by_folder_id.dart';
import 'package:archive/features/bookmark/domain/usecases/save_bookmark.dart';
import 'package:archive/features/bookmark/domain/usecases/delete_bookmark.dart';
import 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  final GetAllBookmarks _getAllBookmarks;
  final GetBookmarksByFolderId _getBookmarksByFolderId;
  final SaveBookmark _saveBookmark;
  final DeleteBookmark _deleteBookmark;

  List<BookmarkEntity> _currentList = [];
  String? _currentFolderId;

  BookmarkCubit({
    required GetAllBookmarks getAllBookmarks,
    required GetBookmarksByFolderId getBookmarksByFolderId,
    required SaveBookmark saveBookmark,
    required DeleteBookmark deleteBookmark,
  }) : _getAllBookmarks = getAllBookmarks,
       _getBookmarksByFolderId = getBookmarksByFolderId,
       _saveBookmark = saveBookmark,
       _deleteBookmark = deleteBookmark,
       super(const BookmarkInitial());

  Future<void> loadAll() async {
    _currentFolderId = null;
    emit(const BookmarkLoading());
    final res = await _getAllBookmarks.call();

    res.match((failure) => emit(BookmarkError(failure.message)), (bookmarks) {
      _currentList = bookmarks;
      emit(BookmarkLoaded(_currentList));
    });
  }

  Future<void> loadByFolderId(String folderId) async {
    _currentFolderId = folderId;
    emit(const BookmarkLoading());
    final res = await _getBookmarksByFolderId.call(folderId);

    res.match((failure) => emit(BookmarkError(failure.message)), (bookmarks) {
      _currentList = bookmarks;
      emit(BookmarkLoaded(_currentList));
    });
  }

  void searchBookmarks(String query) {
    if (query.isEmpty) {
      emit(BookmarkLoaded(_currentList));
      return;
    }

    final lowerQuery = query.toLowerCase();
    final filteredList = _currentList.where((bookmark) {
      final nameMatches = bookmark.title.toLowerCase().contains(lowerQuery);
      final notesMatch = bookmark.description.toLowerCase().contains(
        lowerQuery,
      );
      return nameMatches || notesMatch;
    }).toList();

    emit(BookmarkLoaded(filteredList));
  }

  void filterByType(String type) {
    if (type.isEmpty) {
      emit(BookmarkLoaded(_currentList));
      return;
    }

    final filteredList = _currentList.where((bookmark) {
      return bookmark.tags.contains(type);
    }).toList();

    emit(BookmarkLoaded(filteredList));
  }

  Future<void> addBookmark(BookmarkEntity newBookmark) async {
    final res = await _saveBookmark.call(newBookmark);
    await res.match(
      (failure) async => emit(BookmarkError(failure.message)),
      (_) async => await _refresh(),
    );
  }

  Future<void> deleteBookmark(String id) async {
    final res = await _deleteBookmark.call(id);
    await res.match(
      (failure) async =>
          emit(BookmarkError('Failed to delete bookmark: ${failure.message}')),
      (_) async => await _refresh(),
    );
  }

  Future<void> updateBookmark(BookmarkEntity updatedBookmark) async {
    final res = await _saveBookmark.call(updatedBookmark);
    await res.match(
      (failure) async =>
          emit(BookmarkError('Failed to update bookmark: ${failure.message}')),
      (_) async => await _refresh(),
    );
  }

  Future<void> _refresh() async {
    if (_currentFolderId != null) {
      await loadByFolderId(_currentFolderId!);
    } else {
      await loadAll();
    }
  }
}
