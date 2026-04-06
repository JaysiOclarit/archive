import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IBookmarkDataProvider {
  /// Fetches all bookmarks as raw Maps, regardless of what folder they are in.
  /// Fetch bookmarks for a specific user.
  Future<List<Map<String, dynamic>>> getRawBookmarks(String userId);

  /// Fetch bookmarks for a specific user and folder.
  Future<List<Map<String, dynamic>>> getRawBookmarksByFolder(
    String userId,
    String folderId,
  );

  /// Saves a single bookmark (represented as a Map) to the database.
  Future<void> saveRawBookmark(Map<String, dynamic> rawBookmark);

  /// Deletes a collection by its ID.
  Future<void> deleteBookmark(String id);
}

class MockBookmarkProvider implements IBookmarkDataProvider {
  // A fake "database" table specifically for bookmarks
  final List<Map<String, dynamic>> _mockDatabase = [
    {
      'id': 'bm_1',
      'url': 'https://pub.dev',
      'title': 'Dart Packages',
      'description': 'The official repository for Dart and Flutter packages.',
      'imageUrl': 'https://pub.dev/static/img/pub-dev-icon-cover-image.png',
      'createdAt': '2023-10-01T12:00:00Z',
      'folderId': 'col_1', // Belongs to a folder
      'tags': ['flutter', 'packages'],
    },
    {
      'id': 'bm_2',
      'url': 'https://flutter.dev',
      'title': 'Flutter - Build apps for any screen',
      'description': 'Flutter transforms the app development process.',
      'imageUrl':
          'https://storage.googleapis.com/cms-storage-bucket/70760bf1e88b184bb1bc.png',
      'createdAt': '2023-10-05T14:30:00Z',
      'folderId': null, // Unassigned bookmark!
      'tags': ['ui', 'mobile'],
    },
  ];
  @override
  Future<List<Map<String, dynamic>>> getRawBookmarksByFolder(
    String userId,
    String folderId,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    // Look through the list and only keep the ones where folderId matches
    return _mockDatabase.where((bm) => bm['folderId'] == folderId).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getRawBookmarks(String userId) async {
    // Simulate a 1-second network/database delay
    await Future.delayed(const Duration(seconds: 1));
    return _mockDatabase;
  }

  @override
  Future<void> saveRawBookmark(Map<String, dynamic> rawBookmark) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Check if it exists to update it, otherwise add it as new
    final index = _mockDatabase.indexWhere(
      (bm) => bm['id'] == rawBookmark['id'],
    );
    if (index >= 0) {
      _mockDatabase[index] = rawBookmark; // Update
    } else {
      _mockDatabase.add(rawBookmark); // Insert
    }
  }

  @override
  Future<void> deleteBookmark(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockDatabase.removeWhere((bm) => bm['id'] == id);
  }
}

class FirebaseBookmarkProvider implements IBookmarkDataProvider {
  // Get an instance of the Firestore database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseBookmarkProvider();

  @override
  Future<List<Map<String, dynamic>>> getRawBookmarksByFolder(
    String userId,
    String folderId,
  ) async {
    if (userId.isEmpty) throw Exception('User not logged in!');

    // Compound Query: Must match BOTH the user ID and the Folder ID
    final snapshot = await _firestore
        .collection('bookmarks')
        .where('userId', isEqualTo: userId)
        .where('folderId', isEqualTo: folderId)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getRawBookmarks(String userId) async {
    if (userId.isEmpty) throw Exception('User not logged in!');

    // Filter: Only get bookmarks owned by this user
    final snapshot = await _firestore
        .collection('bookmarks')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  @override
  Future<void> saveRawBookmark(Map<String, dynamic> rawBookmark) async {
    // We use .set() with SetOptions(merge: true).
    // This acts exactly like your Mock logic: if it exists, it updates it.
    // If it doesn't exist, it creates a new one.
    await _firestore
        .collection('bookmarks')
        .doc(rawBookmark['id'])
        .set(rawBookmark, SetOptions(merge: true));
  }

  @override
  Future<void> deleteBookmark(String id) async {
    // Simply find the document by its ID and delete it
    await _firestore.collection('bookmarks').doc(id).delete();
  }
}
