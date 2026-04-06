import 'package:fpdart/fpdart.dart';
import 'package:archive/core/errors/failure.dart';
import 'package:archive/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserId {
  final AuthRepository repository;

  const GetCurrentUserId({required this.repository});

  Future<Either<Failure, String?>> call() {
    try {
      // repository.currentUserId is synchronous; wrap in Future for consistency
      final id = repository.currentUserId;
      return Future.value(Right(id));
    } catch (e) {
      return Future.value(Left(Failure('Failed to read current user id: $e')));
    }
  }
}
