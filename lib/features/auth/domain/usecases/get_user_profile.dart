import 'package:fpdart/fpdart.dart';
import 'package:archive/core/errors/failure.dart';
import 'package:archive/features/auth/domain/repositories/auth_repository.dart';
import 'package:archive/features/auth/domain/entities/user_entity.dart';

class GetUserProfile {
  final AuthRepository repository;

  const GetUserProfile({required this.repository});

  Future<Either<Failure, UserEntity>> call(String userId) {
    return repository.getUserProfile(userId);
  }
}
