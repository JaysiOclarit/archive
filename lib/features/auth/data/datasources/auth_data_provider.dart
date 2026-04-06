import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthDataProvider {
  Future<String> signUp(String email, String password);
  Future<String> signIn(String email, String password);

  Future<void> signOut();
  String? getCurrentUserId(); // Returns null if not logged in

  Future<void> sendPasswordResetEmail(String email);
  // --- THE NEW FIRESTORE METHODS ---
  Future<Map<String, dynamic>?> getUserProfile(String userId);
  Future<void> updateProfile(String userId, Map<String, dynamic> profileData);
}

class FirebaseAuthProvider implements IAuthDataProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<String> signUp(String email, String password) async {
    final credentials = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final userId = credentials.user!.uid;

    // Create the Shadow Document with ONLY the required fields
    await _firestore.collection('users').doc(userId).set({
      'email': email,
      'name': 'New Curator',
      // No title or bio saved here. They remain null until the user edits them!
    });

    return userId;
  }

  @override
  Future<String> signIn(String email, String password) async {
    final credentials = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credentials.user!.uid;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    // Fetch the custom fields from the Firestore 'users' collection
    final doc = await _firestore.collection('users').doc(userId).get();
    return doc.data();
  }

  @override
  Future<void> updateProfile(
    String userId,
    Map<String, dynamic> profileData,
  ) async {
    // Save custom fields (like title and bio) to Firestore
    await _firestore
        .collection('users')
        .doc(userId)
        .set(profileData, SetOptions(merge: true));
  }
}
