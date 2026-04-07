import 'package:archive/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:archive/features/auth/domain/repositories/auth_repository.dart';
import 'package:archive/features/auth/domain/entities/user_entity.dart';
import 'package:archive/features/auth/data/datasources/auth_data_provider.dart';
import 'package:archive/features/auth/data/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final IAuthDataProvider _authProvider;

  AuthRepositoryImpl({required IAuthDataProvider authProvider})
    : _authProvider = authProvider;

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    try {
      final id = await _authProvider.signIn(email, password);
      return Right(id);
    } catch (e) {
      return Left(Failure('Failed to sign in: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> register(
    String email,
    String password, {
    String? name,
  }) async {
    try {
      final id = await _authProvider.signUp(email, password, name: name);
      return Right(id);
    } catch (e) {
      return Left(Failure('Failed to create account: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await _authProvider.signOut();
      return Right(unit);
    } catch (e) {
      return Left(Failure('Failed to sign out: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPassword(String email) async {
    try {
      await _authProvider.sendPasswordResetEmail(email);
      return Right(unit);
    } catch (e) {
      return Left(Failure('Failed to send reset email: $e'));
    }
  }

  /// Fetches the custom User Model and maps it to the domain entity
  @override
  Future<Either<Failure, UserEntity>> getUserProfile(String userId) async {
    try {
      final data = await _authProvider.getUserProfile(userId);
      if (data == null) return Left(Failure('User profile not found'));

      final model = UserModel.fromMap(data, userId);
      final entity = UserEntity(
        id: model.id,
        email: model.email,
        name: model.name,
        title: model.title,
        bio: model.bio,
      );
      return Right(entity);
    } catch (e) {
      return Left(Failure('Failed to load profile: $e'));
    }
  }

  /// Maps domain entity back to data model and updates the provider
  @override
  Future<Either<Failure, Unit>> updateProfile(UserEntity updatedUser) async {
    try {
      final model = UserModel(
        id: updatedUser.id,
        email: updatedUser.email,
        name: updatedUser.name,
        title: updatedUser.title,
        bio: updatedUser.bio,
      );
      await _authProvider.updateProfile(model.id, model.toMap());
      return Right(unit);
    } catch (e) {
      return Left(Failure('Failed to update profile: $e'));
    }
  }

  @override
  String? get currentUserId => _authProvider.getCurrentUserId();
}
