import 'package:fpdart/fpdart.dart';
import 'package:archive/core/errors/failure.dart';
import 'package:archive/features/auth/domain/repositories/auth_repository.dart';

class RegisterParams {
  final String email;
  final String password;

  const RegisterParams({required this.email, required this.password});
}

class RegisterUser {
  final AuthRepository repository;

  const RegisterUser({required this.repository});

  Future<Either<Failure, String>> call(RegisterParams params) {
    return repository.register(params.email, params.password);
  }
}
