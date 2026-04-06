import 'package:fpdart/fpdart.dart';
import 'package:archive/core/errors/failure.dart';
import 'package:archive/features/auth/domain/repositories/auth_repository.dart';
import 'package:archive/features/auth/domain/entities/user_entity.dart';

class UpdateProfile {
  final AuthRepository repository;

  const UpdateProfile({required this.repository});

  Future<Either<Failure, Unit>> call(UserEntity updatedUser) {
    return repository.updateProfile(updatedUser);
  }
}
