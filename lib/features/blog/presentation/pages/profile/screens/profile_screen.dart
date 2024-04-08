import 'package:blog_app/core/common/utils/app_colors.dart';
import 'package:blog_app/core/common/utils/custom_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/profile/widgets/custom_drawer.dart';
import 'package:blog_app/features/blog/presentation/pages/profile/widgets/custom_rounded_chip.dart';
import 'package:blog_app/features/blog/presentation/widgets/post_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 300,
        flexibleSpace: Container(
          child: SafeArea(
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  customSnackbar(state.message);
                }
              },
              builder: (context, state) {
                if (state is AuthSuccess) {
                  final user = state.user;

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DrawerButton(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 54,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: inversePrimaryColor(),
                                child: Icon(CupertinoIcons.person),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(user.name),
                            Spacer(),
                            Chip(label: Text("Edit")),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: Get.width * 0.35,
                              child: CustomRoundedChip(
                                label: "Followers 100k",
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.35,
                              child: CustomRoundedChip(
                                label: "Following 20",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                      ],
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ),
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            customSnackbar(state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogFetchByUserIdSuccess) {
            final List<Blog> blogs = state.blogs;
            return SingleChildScrollView(
              child: Wrap(
                spacing: 2,
                runSpacing: 2,
                children: blogs
                    .map((e) => GestureDetector(
                          onTap: () => Get.to(() => PostWidget(blog: e)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              e.imageUrl,
                              width: Get.width / 3.03,
                              height: Get.width / 3.03,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
