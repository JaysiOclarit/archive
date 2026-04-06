import 'package:fpdart/fpdart.dart';
import 'package:archive/core/errors/failure.dart';
import 'package:archive/features/collection/domain/repositories/collection_repository.dart';

class DeleteCollection {
  final CollectionRepository repository;

  const DeleteCollection({required this.repository});

  Future<Either<Failure, Unit>> call(String id) {
    return repository.deleteCollection(id);
  }
}
