import 'package:fpdart/fpdart.dart';
import 'package:archive/core/errors/failure.dart';
import 'package:archive/features/bookmark/data/datasources/bookmark_data_provider.dart';
import 'package:archive/features/bookmark/data/models/bookmark_model.dart';
import 'package:archive/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:archive/features/bookmark/domain/repositories/bookmark_repository.dart';
import 'package:archive/features/auth/domain/repositories/auth_repository.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  final IBookmarkDataProvider _dataProvider;
  final AuthRepository _authRepository;

  BookmarkRepositoryImpl({
    required IBookmarkDataProvider dataProvider,
    required AuthRepository authRepository,
  }) : _dataProvider = dataProvider,
       _authRepository = authRepository;

  @override
  Future<Either<Failure, List<BookmarkEntity>>> getAllBookmarks() async {
    try {
      final userId = _authRepository.currentUserId;
      if (userId == null) return Left(Failure('User not logged in'));
      final rawData = await _dataProvider.getRawBookmarks(userId);

      return Right(
        rawData.map((map) => BookmarkModel.fromMap(map).toEntity()).toList(),
      );
    } catch (e) {
      return Left(Failure('Failed to fetch bookmarks: $e'));
    }
  }

  @override
  Future<Either<Failure, List<BookmarkEntity>>> getBookmarksByFolderId(
    String folderId,
  ) async {
    try {
      final userId = _authRepository.currentUserId;
      if (userId == null) return Left(Failure('User not logged in'));
      final rawData = await _dataProvider.getRawBookmarksByFolder(
        userId,
        folderId,
      );

      return Right(
        rawData.map((map) => BookmarkModel.fromMap(map).toEntity()).toList(),
      );
    } catch (e) {
      return Left(Failure('Failed to load folder bookmarks: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveBookmark(BookmarkEntity bookmark) async {
    try {
      // 1. Get the current logged-in user's ID
      final userId = _authRepository.currentUserId;
      if (userId == null) return Left(Failure('User not logged in'));

      final model = BookmarkModel(
        id: bookmark.id,
        url: bookmark.url,
        title: bookmark.title,
        description: bookmark.description,
        imageUrl: bookmark.imageUrl,
        createdAt: bookmark.createdAt,
        folderId: bookmark.folderId,
        tags: bookmark.tags,
      );

      // 2. Convert to map
      final map = model.toMap();

      // 3. INJECT THE USER ID before passing it to the database
      map['userId'] = userId;

      await _dataProvider.saveRawBookmark(map);
      return Right(unit);
    } catch (e) {
      return Left(Failure('Failed to save bookmark: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteBookmark(String id) async {
    try {
      await _dataProvider.deleteBookmark(id);
      return Right(unit);
    } catch (e) {
      return Left(Failure('Failed to delete bookmark: $e'));
    }
  }
}
