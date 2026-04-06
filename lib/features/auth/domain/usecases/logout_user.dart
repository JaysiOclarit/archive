import 'package:fpdart/fpdart.dart';
import 'package:archive/core/errors/failure.dart';
import 'package:archive/features/auth/domain/repositories/auth_repository.dart';

class LogoutUser {
  final AuthRepository repository;

  const LogoutUser({required this.repository});

  Future<Either<Failure, Unit>> call() {
    return repository.logout();
  }
}
