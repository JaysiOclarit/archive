import 'package:archive/features/auth/data/datasources/auth_data_provider.dart';
import 'package:archive/features/auth/data/models/user_model.dart';

class AuthRepository {
  final IAuthDataProvider _authProvider;

  AuthRepository({required IAuthDataProvider authProvider})
    : _authProvider = authProvider;

  Future<String> login(String email, String password) async {
    try {
      return await _authProvider.signIn(email, password);
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<String> register(String email, String password) async {
    try {
      return await _authProvider.signUp(email, password);
    } catch (e) {
      throw Exception('Failed to create account: $e');
    }
  }

  Future<void> logout() async {
    await _authProvider.signOut();
  }

  Future<void> resetPassword(String email) async {
    try {
      await _authProvider.sendPasswordResetEmail(email);
    } catch (e) {
      throw Exception('Failed to send reset email: $e');
    }
  }

  /// Fetches the custom User Model
  Future<UserModel> getUserProfile(String userId) async {
    try {
      final data = await _authProvider.getUserProfile(userId);
      if (data == null) throw Exception('User profile not found in database');

      return UserModel.fromMap(data, userId);
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }

  /// Takes a UserModel and translates it back to a Map for Firestore
  Future<void> updateProfile(UserModel updatedUser) async {
    try {
      await _authProvider.updateProfile(updatedUser.id, updatedUser.toMap());
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  String? get currentUserId => _authProvider.getCurrentUserId();
}
