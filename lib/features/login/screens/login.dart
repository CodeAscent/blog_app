import 'package:blog_app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Login.",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 20,
              ),
              RepeatedTextField(
                hint: "Email",
                validator: (val) => val!.length < 10
                    ? "Please enter a valid email address"
                    : null,
                controller: _emailController,
              ),
              SizedBox(
                height: 20,
              ),
              RepeatedTextField(
                hint: "Password",
                validator: (val) => val!.length < 8
                    ? "Please enter a 8 characters password"
                    : null,
                controller: _passwordController,
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: Text("Don\'t have an account?"),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_globalKey.currentState!.validate()) {}
                },
                child: Text("Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
