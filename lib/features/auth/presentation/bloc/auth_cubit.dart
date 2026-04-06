import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';
import 'package:archive/features/auth/domain/entities/user_entity.dart';
import 'package:archive/features/auth/domain/usecases/login_user.dart';
import 'package:archive/features/auth/domain/usecases/logout_user.dart';
import 'package:archive/features/auth/domain/usecases/register_user.dart';
import 'package:archive/features/auth/domain/usecases/reset_password.dart';
import 'package:archive/features/auth/domain/usecases/get_user_profile.dart';
import 'package:archive/features/auth/domain/usecases/update_profile.dart';
import 'package:archive/features/auth/domain/usecases/get_current_user_id.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUser _loginUser;
  final LogoutUser _logoutUser;
  final RegisterUser _registerUser;
  final ResetPassword _resetPassword;
  final GetUserProfile _getUserProfile;
  final UpdateProfile _updateProfile;
  final GetCurrentUserId _getCurrentUserId;

  AuthCubit({
    required LoginUser loginUser,
    required LogoutUser logoutUser,
    required RegisterUser registerUser,
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
       super(const AuthInitial()); // Added const

  Future<void> checkAuthStatus() async {
    final idRes = await _getCurrentUserId.call();

    if (isClosed) return; // 3. Async Emit Safety

    // 2. fpdart consistency: Using .fold() everywhere
    await idRes.fold((failure) async => emit(const AuthUnauthenticated()), (
      userId,
    ) async {
      if (userId != null) {
        final res = await _getUserProfile.call(userId);

        if (isClosed) return; // Safety check before inner emit

        res.fold(
          (failure) => emit(const AuthUnauthenticated()),
          (userEntity) => emit(AuthAuthenticated(userEntity)),
        );
      } else {
        emit(const AuthUnauthenticated());
      }
    });
  }

  Future<void> signUp(String email, String password) async {
    emit(const AuthLoading());
    final res = await _registerUser.call(
      RegisterParams(email: email, password: password),
    );

    if (isClosed) return;

    res.fold(
      (failure) => emit(AuthError(failure.message)),
      (userId) => logIn(email, password),
    );
  }

  Future<void> logIn(String email, String password) async {
    emit(const AuthLoading());

    final loginRes = await _loginUser.call(
      LoginParams(email: email, password: password),
    );

    if (isClosed) return;

    await loginRes.fold(
      (failure) async {
        emit(AuthError(failure.message));
      },
      (userId) async {
        final profileRes = await _getUserProfile.call(userId);

        if (isClosed) return;

        profileRes.fold(
          (failure) => emit(AuthError(failure.message)),
          (userEntity) => emit(AuthAuthenticated(userEntity)),
        );
      },
    );
  }

  Future<void> logOut() async {
    final res = await _logoutUser.call();

    if (isClosed) return;

    res.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const AuthUnauthenticated()),
    );
  }

  Future<void> resetUserPassword(String email) async {
    emit(const AuthLoading());
    final res = await _resetPassword.call(email);

    if (isClosed) return;

    res.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const AuthPasswordResetSuccess()),
    );
  }

  Future<void> updateProfile(UserEntity updatedUser) async {
    final res = await _updateProfile.call(updatedUser);

    if (isClosed) return;

    res.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthAuthenticated(updatedUser)),
    );
  }
}
