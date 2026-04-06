import 'package:fpdart/fpdart.dart';
import 'package:archive/core/errors/failure.dart';
import 'package:archive/features/collection/data/datasources/collection_data_provider.dart';
import 'package:archive/features/collection/data/models/collection_model.dart';
import 'package:archive/features/collection/domain/entities/collection_entity.dart';
import 'package:archive/features/collection/domain/repositories/collection_repository.dart';
import 'package:archive/features/auth/domain/repositories/auth_repository.dart';

class CollectionRepositoryImpl implements CollectionRepository {
  final ICollectionDataProvider _dataProvider;
  final AuthRepository _authRepository;

  CollectionRepositoryImpl({
    required ICollectionDataProvider dataProvider,
    required AuthRepository authRepository,
  }) : _dataProvider = dataProvider,
       _authRepository = authRepository;

  @override
  Future<Either<Failure, List<CollectionEntity>>> getAllCollections() async {
    try {
      final userId = _authRepository.currentUserId;
      if (userId == null) return Left(Failure('User not logged in'));
      final rawData = await _dataProvider.getRawCollections(userId);

      final collections = rawData
          .map((map) => CollectionModel.fromMap(map).toEntity())
          .toList();
      return Right(collections);
    } catch (e) {
      return Left(Failure('Failed to load collections: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveCollection(
    CollectionEntity collection,
  ) async {
    try {
      final model = CollectionModel(
        id: collection.id,
        userId: collection.userId,
        name: collection.name,
        notes: collection.notes,
        iconCodePoint: collection.iconCodePoint,
        iconFontFamily: collection.iconFontFamily,
        bookmarks: collection.bookmarks,
        createdAt: collection.createdAt,
      );
      final rawMap = model.toMap();
      await _dataProvider.saveRawCollection(rawMap);
      return Right(unit);
    } catch (e) {
      return Left(Failure('Failed to save collection: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCollection(String id) async {
    try {
      await _dataProvider.deleteCollection(id);
      return Right(unit);
    } catch (e) {
      return Left(Failure('Failed to delete collection: $e'));
    }
  }
}
