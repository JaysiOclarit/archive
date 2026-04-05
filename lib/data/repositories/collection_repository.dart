// lib/data/repositories/collection_repository.dart

import 'package:archive/data/dataproviders/collection_data_provider.dart';
import 'package:archive/data/models/collection_model.dart';

class CollectionRepository {
  // 1. Dependency Injection: We use the Interface, not the Mock!
  final ICollectionDataProvider _dataProvider;

  CollectionRepository({required ICollectionDataProvider dataProvider})
    : _dataProvider = dataProvider;

  /// Fetches raw maps from the provider and converts them into a List of Collections
  Future<List<Collection>> getAllCollections() async {
    try {
      // Step A: Get the messy, raw data from the provider
      final rawData = await _dataProvider.getRawCollections();

      // Step B: Use your robust fromMap factory to translate them safely
      return rawData.map((map) => Collection.fromMap(map)).toList();
    } catch (e) {
      // 3. Error Handling: Catch raw errors and throw clean Exceptions
      throw Exception('Failed to load collections: $e');
    }
  }

  /// Converts a Collection object into a Map and tells the provider to save it
  Future<void> saveCollection(Collection collection) async {
    try {
      // Step A: Translate the clean Dart object back into a raw Map
      final rawMap = collection.toMap();

      // Step B: Send it to the provider to be saved
      await _dataProvider.saveRawCollection(rawMap);
    } catch (e) {
      throw Exception('Failed to save collection: $e');
    }
  }

  /// Tells the provider to delete a collection by its ID
  Future<void> deleteCollection(String id) async {
    try {
      await _dataProvider.deleteCollection(id);
    } catch (e) {
      throw Exception('Failed to delete collection: $e');
    }
  }
}
