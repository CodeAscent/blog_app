import 'package:blog_app/core/common/utils/app_colors.dart';
import 'package:blog_app/core/common/utils/custom_snackbar.dart';
import 'package:blog_app/core/common/widgets/custom_loader.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login/screens/login.dart';
import 'package:blog_app/features/blog/presentation/pages/profile/widgets/profile_drawer_child.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            customSnackbar(state.message);
          }
          if (state is AuthUserLogoutSuccess) {
            customSnackbar(state.message);
            Get.offUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()),
                (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return CustomLoader();
          }

          return Drawer(
            width: Get.width * 0.5,
            surfaceTintColor: null,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  CircleAvatar(
                    backgroundColor: inversePrimaryColor(),
                    radius: 40,
                    child: Icon(CupertinoIcons.person),
                  ),
                  SizedBox(height: 30),
                  Divider(),
                  SizedBox(height: 30),
                  ProfileDrawerChild(
                    label: "Account",
                    onPressed: () {},
                    icon: Icons.person,
                  ),
                  ProfileDrawerChild(
                    label: "Settings",
                    onPressed: () {},
                    icon: CupertinoIcons.settings,
                  ),
                  ProfileDrawerChild(
                    label: "Logout",
                    onPressed: () {
                      Get.back();
                      Get.defaultDialog(
                        buttonColor: primaryColor(),
                        confirmTextColor: Colors.white,
                        middleText: "Are you sure you want to\nlogout?",
                        onConfirm: () {
                          Get.back();
                          context.read<AuthBloc>().add(AuthUserLogout());
                        },
                      );
                    },
                    icon: Icons.logout,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
