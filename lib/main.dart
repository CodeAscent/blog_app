
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/core/common/cubit/app_user_cubit.dart';
import 'package:blog_app/core/common/utils/app_colors.dart';
import 'package:blog_app/features/blog/presentation/pages/bottom_nav/bottom_nav.dart';
import 'package:blog_app/features/auth/presentation/pages/signup/screens/signup.dart';
import 'package:blog_app/get_it_dependency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
    BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

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
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) return BottomNav();
          return const SignUpScreen();
        },
      ),
    );
  }
}
