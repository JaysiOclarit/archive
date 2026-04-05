import 'package:archive/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:archive/data/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;

  AuthCubit({required AuthRepository repository})
    : _repository = repository,
      super(AuthInitial());

  /// Checks if the user is already logged in when they open the app
  Future<void> checkAuthStatus() async {
    final userId = _repository.currentUserId;
    if (userId != null) {
      // User is logged into Firebase, now fetch their custom profile!
      try {
        final userProfile = await _repository.getUserProfile(userId);
        emit(Authenticated(userProfile));
      } catch (e) {
        // If the profile fails to load, force them to log in again
        emit(Unauthenticated());
      }
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> logIn(String email, String password) async {
    try {
      emit(AuthLoading());
      final userId = await _repository.login(email, password);

      // Fetch the custom profile after successful login
      final userProfile = await _repository.getUserProfile(userId);
      emit(Authenticated(userProfile));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logOut() async {
    await _repository.logout();
    emit(Unauthenticated());
  }

  /// Triggers the Firebase password reset email
  Future<void> resetPassword(String email) async {
    try {
      await _repository.resetPassword(email);
      // We don't change the state here, because they are still Unauthenticated
      // The UI will just show a "Check your email!" SnackBar when this finishes.
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// Update Profile function for when they edit their bio
  Future<void> updateProfile(UserModel updatedUser) async {
    try {
      await _repository.updateProfile(updatedUser);
      // Instantly update the UI with the new data!
      emit(Authenticated(updatedUser));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
