import 'package:blog_app/core/common/utils/app_colors.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class PostWidget extends StatelessWidget {
  final Blog blog;
  const PostWidget({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
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
        )),
      ),
    );
  }
}
