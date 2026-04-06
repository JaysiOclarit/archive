import 'package:fpdart/fpdart.dart';
import 'package:archive/core/errors/failure.dart';
import 'package:archive/features/collection/domain/entities/collection_entity.dart';

abstract class CollectionRepository {
  Future<Either<Failure, List<CollectionEntity>>> getAllCollections();
  Future<Either<Failure, Unit>> saveCollection(CollectionEntity collection);
  Future<Either<Failure, Unit>> deleteCollection(String id);
}
