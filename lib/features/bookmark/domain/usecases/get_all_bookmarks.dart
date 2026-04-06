import 'package:fpdart/fpdart.dart';
import 'package:archive/core/errors/failure.dart';
import 'package:archive/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:archive/features/bookmark/domain/repositories/bookmark_repository.dart';

class GetAllBookmarks {
  final BookmarkRepository repository;

  const GetAllBookmarks({required this.repository});

  Future<Either<Failure, List<BookmarkEntity>>> call() {
    return repository.getAllBookmarks();
  }
}
