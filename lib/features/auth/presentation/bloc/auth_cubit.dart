import 'package:archive/features/auth/domain/usecases/register_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';
import 'package:archive/features/auth/domain/entities/user_entity.dart';
import 'package:archive/features/auth/domain/usecases/login_user.dart';
import 'package:archive/features/auth/domain/usecases/logout_user.dart';
import 'package:archive/features/auth/domain/usecases/reset_password.dart';
import 'package:archive/features/auth/domain/usecases/get_user_profile.dart';
import 'package:archive/features/auth/domain/usecases/update_profile.dart';
import 'package:archive/features/auth/domain/usecases/get_current_user_id.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUser _loginUser;
  final LogoutUser _logoutUser;
  final RegisterUser _registerUser; // Added missing usecase
  final ResetPassword _resetPassword;
  final GetUserProfile _getUserProfile;
  final UpdateProfile _updateProfile;
  final GetCurrentUserId _getCurrentUserId;

  AuthCubit({
    required LoginUser loginUser,
    required LogoutUser logoutUser,
    required RegisterUser registerUser, // Added
    required ResetPassword resetPassword,
    required GetUserProfile getUserProfile,
    required UpdateProfile updateProfile,
    required GetCurrentUserId getCurrentUserId,
  }) : _loginUser = loginUser,
       _registerUser = registerUser,
       _logoutUser = logoutUser,
       _resetPassword = resetPassword,
       _getUserProfile = getUserProfile,
       _updateProfile = updateProfile,
       _getCurrentUserId = getCurrentUserId,
       super(AuthInitial());

  /// Checks if the user is already logged in when they open the app
  Future<void> checkAuthStatus() async {
    final idRes = await _getCurrentUserId.call();
    await idRes.match((failure) async => emit(Unauthenticated()), (
      userId,
    ) async {
      if (userId != null) {
        final res = await _getUserProfile.call(userId);
        res.match(
          (failure) => emit(Unauthenticated()),
          (userEntity) => emit(Authenticated(userEntity)),
        );
      } else {
        emit(Unauthenticated());
      }
    });
  }

  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());
    final res = await _registerUser.call(
      RegisterParams(email: email, password: password),
    );

    res.fold(
      (failure) => emit(AuthError(failure.message)),
      (userId) => logIn(email, password), // Auto-login after signup
    );
  }

  Future<void> logIn(String email, String password) async {
    emit(AuthLoading());

    final loginRes = await _loginUser.call(
      LoginParams(email: email, password: password),
    );
    await loginRes.match(
      (failure) async {
        emit(AuthError(failure.message));
      },
      (userId) async {
        final profileRes = await _getUserProfile.call(userId);
        profileRes.match(
          (failure) => emit(AuthError(failure.message)),
          (userEntity) => emit(Authenticated(userEntity)),
        );
      },
    );
  }

  Future<void> logOut() async {
    final res = await _logoutUser.call();
    res.match(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(Unauthenticated()),
    );
  }

  Future<void> resetUserPassword(String email) async {
    emit(AuthLoading());
    final res = await _resetPassword.call(email);

    res.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(PasswordResetSuccess()),
    );
  }

  /// Update Profile function for when they edit their bio
  Future<void> updateProfile(UserEntity updatedUser) async {
    final res = await _updateProfile.call(updatedUser);
    res.match(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(Authenticated(updatedUser)),
    );
  }
}
