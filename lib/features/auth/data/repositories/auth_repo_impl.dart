import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, User>> login(
      {required String email, required String password}) async {
    return _getUser(() async =>
        await authRemoteDataSource.login(email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signUp(
      {required String email,
      required String password,
      required String name}) async {
    return _getUser(() async => await authRemoteDataSource.signUp(
        email: email, name: name, password: password));
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      final user = await fn();
      return right(user);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await authRemoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure("you are not logged in!"));
      }
      return right(user);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, String>> logoutUser() async {
    try {
      final res = await authRemoteDataSource.logoutUser();
      return right(res);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
