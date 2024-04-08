import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signUp({
    required String email,
    required String name,
    required String password,
  });
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();

  Future<String> logoutUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(password: password, email: email);

      return UserModel.fromJson(response.user!.toJson())
          .copyWith(email: currentUserSession!.user.email);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<UserModel> signUp({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth
          .signUp(password: password, email: email, data: {"name": name});
      if (response.user == null) {
        throw ServerExceptions("User not found");
      }
      return UserModel.fromJson(response.user!.toJson())
          .copyWith(email: currentUserSession!.user.email);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final res = await supabaseClient
            .from("profiles")
            .select()
            .eq('id', currentUserSession!.user.id);
        return UserModel.fromJson(res.first)
            .copyWith(email: currentUserSession!.user.email);
      }
      return null;
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<String> logoutUser() async {
    try {
      await supabaseClient.auth.signOut();
      return "You have been logged out";
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }
}
