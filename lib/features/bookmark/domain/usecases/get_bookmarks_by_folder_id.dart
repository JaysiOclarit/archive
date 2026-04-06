import 'package:fpdart/fpdart.dart';
import 'package:archive/core/errors/failure.dart';
import 'package:archive/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:archive/features/bookmark/domain/repositories/bookmark_repository.dart';

class GetBookmarksByFolderId {
  final BookmarkRepository repository;

  const GetBookmarksByFolderId({required this.repository});

  Future<Either<Failure, List<BookmarkEntity>>> call(String folderId) {
    return repository.getBookmarksByFolderId(folderId);
  }
}
