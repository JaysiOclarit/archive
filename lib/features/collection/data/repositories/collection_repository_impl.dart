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
      // 1. Get the current logged-in user's ID
      final userId = _authRepository.currentUserId;
      if (userId == null) return Left(Failure('User not logged in'));

      final model = CollectionModel(
        id: collection.id,
        userId: userId, // We can inject it directly into the model here
        name: collection.name,
        notes: collection.notes,
        iconCodePoint: collection.iconCodePoint,
        iconFontFamily: collection.iconFontFamily,
        bookmarks: collection.bookmarks,
        createdAt: collection.createdAt,
      );

      // 2. Convert to map
      final map = model.toMap();

      // 3. FORCE INJECT THE USER ID (Just in case the map conversion drops it)
      map['userId'] = userId;

      await _dataProvider.saveRawCollection(map);
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
