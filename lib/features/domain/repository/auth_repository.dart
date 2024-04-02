import 'package:blog_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUp({
    required String email,
    required String password,
    required String name,
  });
  Future<Either<Failure, String>> login({
    required String email,
    required String password,
  });
}
