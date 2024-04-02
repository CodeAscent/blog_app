import 'package:blog_app/bloc/auth_bloc.dart';
import 'package:blog_app/core/secrets/supabase_app.dart';
import 'package:blog_app/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:blog_app/features/bottom_nav/bottom_nav.dart';
import 'package:blog_app/features/domain/repository/auth_repository.dart';
import 'package:blog_app/features/domain/useCases/user_sign_up.dart';
import 'package:blog_app/features/signup/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
      url: SupabaseSecrets.url, anonKey: SupabaseSecrets.anonKey);
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => AuthBloc(
        userSignUp: UserSignUp(
          AuthRepositoryImpl(AuthRemoteDataSourceImpl(supabase.client)),
        ),
      ),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.changeThemeMode(ThemeMode.dark);
    return GetMaterialApp(
      title: 'Blog IT',
      darkTheme: ThemeData(
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                backgroundColor: Colors.pink.shade100)),
        colorScheme: ColorScheme.dark(
            primary: Colors.pink, inversePrimary: Colors.pink.shade100),
      ),
      home: const SignUpScreen(),
    );
  }
}
