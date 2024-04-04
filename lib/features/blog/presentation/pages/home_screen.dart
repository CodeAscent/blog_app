import 'package:blog_app/core/common/utils/app_colors.dart';
import 'package:blog_app/core/common/utils/custom_snackbar.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(GetAllBlogsEvent());
  }

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
            return CircularProgressIndicator();
          }
          if (state is BlogFetchSuccess) {
            return ListView.builder(
              // dragStartBehavior: DragStartBehavior.down,
              physics: BouncingScrollPhysics(),
              itemCount: state.blogs.length,
              itemBuilder: (BuildContext context, int index) {
                Blog blog = state.blogs[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(10.0),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Posted By: " +
                              toBeginningOfSentenceCase(blog.ownerName!)),
                          Divider(color: Colors.grey),
                          SizedBox(height: 20),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              blog.imageUrl,
                              height: 300,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 20),
                          Divider(color: Colors.grey),
                          Text(
                            blog.title,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          ReadMoreText(
                            blog.content,
                            trimLines: 2,
                            trimMode: TrimMode.Line,
                            colorClickableText: primaryColor(),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          )
                        ],
                      )),
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
