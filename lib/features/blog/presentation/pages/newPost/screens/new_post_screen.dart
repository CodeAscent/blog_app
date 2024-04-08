import 'dart:io';

import 'package:blog_app/core/common/cubit/app_user_cubit.dart';
import 'package:blog_app/core/common/utils/app_colors.dart';
import 'package:blog_app/core/common/utils/custom_image_picker.dart';
import 'package:blog_app/core/common/utils/custom_snackbar.dart';
import 'package:blog_app/core/common/widgets/custom_loader.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/newPost/widgets/select_image_box.dart';
import 'package:blog_app/features/blog/presentation/pages/newPost/widgets/selected_image_box.dart';
import 'package:blog_app/features/blog/presentation/pages/newPost/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  File? imageFile;
  final formKey = GlobalKey<FormState>();
  List<String> selectedTags = [];
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            customSnackbar(state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return CustomLoader();
          }
          return Form(
            key: formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Post..."),
                          GestureDetector(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                if (imageFile == null) {
                                  return customSnackbar(
                                      "Please select your post image");
                                } else if (selectedTags.isEmpty) {
                                  return customSnackbar(
                                      "Please select tags for your post");
                                }
                                final ownerId = (context
                                        .read<AppUserCubit>()
                                        .state as AppUserLoggedIn)
                                    .user
                                    .id;
                                context.read<BlogBloc>().add(BlogUploadEvent(
                                    ownerId: ownerId,
                                    title: _titleController.text.trim(),
                                    content: _contentController.text.trim(),
                                    tags: selectedTags,
                                    image: imageFile!));
                              }
                            },
                            child: Chip(
                              backgroundColor: primaryColor(),
                              label: Text(
                                "ADD",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                          onTap: () async {
                            final image = await pickImage();
                            if (image != null) {
                              setState(() {
                                imageFile = image;
                              });
                            }
                          },
                          child: imageFile != null
                              ? SelectedImageBox(
                                  imageFile: imageFile,
                                  onPressed: () {
                                    setState(() {
                                      imageFile = null;
                                    });
                                  },
                                )
                              : SelectImageBox()),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            'Technology',
                            'Business',
                            'Software',
                            'Education'
                          ]
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedTags.contains(e)
                                            ? selectedTags.remove(e)
                                            : selectedTags.add(e);
                                      });
                                    },
                                    child: Chip(
                                      color: selectedTags.contains(e)
                                          ? MaterialStatePropertyAll(
                                              primaryColor())
                                          : null,
                                      label: Text(e),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      SizedBox(height: 20),
                      NewPostTextField(
                        hint: "Post Title",
                        controller: _titleController,
                      ),
                      SizedBox(height: 20),
                      NewPostTextField(
                        controller: _contentController,
                        hint: "Post Content",
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
