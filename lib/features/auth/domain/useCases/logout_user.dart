import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LogoutUser {
  final AuthRepository authRepository;

  LogoutUser(this.authRepository);
  Future<Either<Failure, String>> call() async {
    return await authRepository.logoutUser();
  }
}
