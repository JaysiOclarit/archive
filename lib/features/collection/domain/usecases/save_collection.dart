import 'package:fpdart/fpdart.dart';
import 'package:archive/core/errors/failure.dart';
import 'package:archive/features/collection/domain/entities/collection_entity.dart';
import 'package:archive/features/collection/domain/repositories/collection_repository.dart';

class SaveCollection {
  final CollectionRepository repository;

  const SaveCollection({required this.repository});

  Future<Either<Failure, Unit>> call(CollectionEntity collection) {
    return repository.saveCollection(collection);
  }
}
