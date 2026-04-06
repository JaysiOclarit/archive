import 'package:fpdart/fpdart.dart';
import 'package:archive/core/errors/failure.dart';
import 'package:archive/features/collection/domain/entities/collection_entity.dart';
import 'package:archive/features/collection/domain/repositories/collection_repository.dart';

class GetAllCollections {
  final CollectionRepository repository;

  const GetAllCollections({required this.repository});

  Future<Either<Failure, List<CollectionEntity>>> call() {
    return repository.getAllCollections();
  }
}
