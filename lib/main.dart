import 'package:blog_app/bloc/auth_bloc.dart';
import 'package:blog_app/core/common/utils/app_colors.dart';
import 'package:blog_app/core/secrets/supabase_app.dart';
import 'package:blog_app/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:blog_app/features/bottom_nav/bottom_nav.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/useCases/user_sign_up.dart';
import 'package:blog_app/features/signup/screens/signup.dart';
import 'package:blog_app/get_it_dependency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
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
                backgroundColor: inversePrimaryColor())),
        colorScheme: ColorScheme.dark(
            primary: primaryColor(), inversePrimary: inversePrimaryColor()),
      ),
      home: const SignUpScreen(),
    );
  }
}
