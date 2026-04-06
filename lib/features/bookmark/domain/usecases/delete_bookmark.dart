import 'package:fpdart/fpdart.dart';
import 'package:archive/core/errors/failure.dart';
import 'package:archive/features/bookmark/domain/repositories/bookmark_repository.dart';

class DeleteBookmark {
  final BookmarkRepository repository;

  const DeleteBookmark({required this.repository});

  Future<Either<Failure, Unit>> call(String id) {
    return repository.deleteBookmark(id);
  }
}
