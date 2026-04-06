import 'package:fpdart/fpdart.dart';
import 'package:archive/core/errors/failure.dart';
import 'package:archive/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:archive/features/bookmark/domain/repositories/bookmark_repository.dart';

class SaveBookmark {
  final BookmarkRepository repository;

  const SaveBookmark({required this.repository});

  Future<Either<Failure, Unit>> call(BookmarkEntity bookmark) {
    return repository.saveBookmark(bookmark);
  }
}
