import 'package:fpdart/fpdart.dart';
import 'package:archive/core/errors/failure.dart';
import 'package:archive/features/auth/domain/repositories/auth_repository.dart';

class LoginParams {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});
}

class LoginUser {
  final AuthRepository repository;

  const LoginUser({required this.repository});

  Future<Either<Failure, String>> call(LoginParams params) {
    return repository.login(params.email, params.password);
  }
}
