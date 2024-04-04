// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/useCase/use_case.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog(this.blogRepository);
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
        image: params.image,
        title: params.title,
        content: params.content,
        ownerId: params.ownerId,
        tags: params.tags);
  }
}

class UploadBlogParams {
  final String ownerId;
  final String title;
  final String content;
  final List<String> tags;
  final File image;
  UploadBlogParams({
    required this.ownerId,
    required this.title,
    required this.content,
    required this.tags,
    required this.image,
  });
}
