import 'package:fpdart/fpdart.dart';
import 'package:archive/core/errors/failure.dart';
import 'package:archive/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> login(String email, String password);

  Future<Either<Failure, String>> register(
    String email,
    String password, {
    String? name,
  });

  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, Unit>> resetPassword(String email);

  Future<Either<Failure, UserEntity>> getUserProfile(String userId);

  Future<Either<Failure, Unit>> updateProfile(UserEntity updatedUser);

  String? get currentUserId;
}
