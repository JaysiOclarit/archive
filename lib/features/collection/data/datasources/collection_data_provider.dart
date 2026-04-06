// lib/data/dataproviders/collection_data_provider.dart
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ICollectionDataProvider {
  /// Fetches all collections (and their bookmarks) as raw Maps.
  Future<List<Map<String, dynamic>>> getRawCollections(String userId);

  /// Saves a single collection (represented as a Map) to the database.
  Future<void> saveRawCollection(Map<String, dynamic> rawCollection);

  /// Deletes a collection by its ID.
  Future<void> deleteCollection(String id);
}

class MockCollectionProvider implements ICollectionDataProvider {
  // A fake "database" sitting in your phone's temporary memory
  final List<Map<String, dynamic>> _mockDatabase = [
    {
      'id': 'col_1',
      'name': 'Flutter Resources',
      'notes': 'Links to help me learn Flutter and BLoC',
      'iconCodePoint': 0xe2af, // Folder icon
      'iconFontFamily': 'MaterialIcons',
      'createdAt': '2023-10-01T10:00:00Z',
      'bookmarks': [
        {
          'id': 'bm_1',
          'url': 'https://pub.dev',
          'title': 'Dart Packages',
          'description':
              'The official repository for Dart and Flutter packages.',
          'imageUrl': 'https://pub.dev/static/img/pub-dev-icon-cover-image.png',
          'createdAt': '2023-10-01T12:00:00Z',
          'folderId': 'col_1',
          'tags': ['flutter', 'packages'],
        },
      ],
    },
  ];

  @override
  Future<List<Map<String, dynamic>>> getRawCollections(String userId) async {
    // Simulate a 1-second network/database delay
    await Future.delayed(const Duration(seconds: 1));
    return _mockDatabase;
  }

  @override
  Future<void> saveRawCollection(Map<String, dynamic> rawCollection) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Check if it exists to update it, otherwise add it
    final index = _mockDatabase.indexWhere(
      (col) => col['id'] == rawCollection['id'],
    );
    if (index >= 0) {
      _mockDatabase[index] = rawCollection;
    } else {
      _mockDatabase.add(rawCollection);
    }
  }

  @override
  Future<void> deleteCollection(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockDatabase.removeWhere((col) => col['id'] == id);
  }
}

class FirebaseCollectionProvider implements ICollectionDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseCollectionProvider();

  @override
  Future<List<Map<String, dynamic>>> getRawCollections(String userId) async {
    if (userId.isEmpty) {
      throw Exception('Cannot fetch collections: User is not logged in.');
    }

    // THE FILTER: Ask Firebase only for documents where userId matches!
    final snapshot = await _firestore
        .collection('collections')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  @override
  Future<void> saveRawCollection(Map<String, dynamic> rawCollection) async {
    await _firestore
        .collection('collections')
        .doc(rawCollection['id'])
        .set(rawCollection, SetOptions(merge: true));
  }

  @override
  Future<void> deleteCollection(String id) async {
    await _firestore.collection('collections').doc(id).delete();
  }
}
