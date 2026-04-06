import 'package:fpdart/fpdart.dart';
import 'package:archive/core/errors/failure.dart';
import 'package:archive/features/auth/domain/repositories/auth_repository.dart';

class ResetPassword {
  final AuthRepository repository;

  const ResetPassword({required this.repository});

  Future<Either<Failure, Unit>> call(String email) {
    return repository.resetPassword(email);
  }
}
