import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/core/common/cubit/app_user_cubit.dart';
import 'package:blog_app/core/secrets/supabase_app.dart';
import 'package:blog_app/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/useCases/current_user.dart';
import 'package:blog_app/features/auth/domain/useCases/user_login.dart';
import 'package:blog_app/features/auth/domain/useCases/user_sign_up.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      url: SupabaseSecrets.url, anonKey: SupabaseSecrets.anonKey);

  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(serviceLocator<SupabaseClient>()))
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(serviceLocator()))
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    ..registerLazySingleton(() => AuthBloc(
        currentUser: serviceLocator<CurrentUser>(),
        userSignUp: serviceLocator<UserSignUp>(),
        userLogin: serviceLocator<UserLogin>(),
        appUserCubit: serviceLocator<AppUserCubit>()));
}
