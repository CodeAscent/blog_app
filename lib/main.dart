import 'package:blog_app/features/signup/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
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
