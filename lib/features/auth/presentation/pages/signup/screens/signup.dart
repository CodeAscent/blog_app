import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/core/common/utils/custom_snackbar.dart';
import 'package:blog_app/core/common/widgets/custom_loader.dart';
import 'package:blog_app/features/auth/presentation/pages/login/screens/login.dart';
import 'package:blog_app/features/auth/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          customSnackbar(state.message);
        }
        // if (state is AuthSuccess) {
        //   Get.to(() => LoginScreen());
        // }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return CustomLoader();
        }
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
                    "Sign Up.",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  RepeatedTextField(
                    hint: "Username",
                    validator: (val) => val!.length < 5
                        ? "Please enter a upto 5 characters username"
                        : null,
                    controller: _usernameController,
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
                      child: Text("Already have an account?"),
                      onPressed: () {
                        Get.to(() => LoginScreen());
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_globalKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthSignUp(
                            email: _emailController.text.trim(),
                            name: _usernameController.text.trim(),
                            password: _passwordController.text.trim()));
                      }
                    },
                    child: Text("Sign Up"),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
