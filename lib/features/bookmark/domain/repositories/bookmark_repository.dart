import 'package:fpdart/fpdart.dart';
import 'package:archive/core/errors/failure.dart';
import 'package:archive/features/bookmark/domain/entities/bookmark_entity.dart';

abstract class BookmarkRepository {
  Future<Either<Failure, List<BookmarkEntity>>> getAllBookmarks();
  Future<Either<Failure, List<BookmarkEntity>>> getBookmarksByFolderId(
    String folderId,
  );
  Future<Either<Failure, Unit>> saveBookmark(BookmarkEntity bookmark);
  Future<Either<Failure, Unit>> deleteBookmark(String id);
}
