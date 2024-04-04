import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/data/dataSources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  BlogRepositoryImpl(this.blogRemoteDataSource);
  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String ownerId,
    required List<String> tags,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
          id: await Uuid().v1(),
          ownerId: ownerId,
          title: title,
          content: content,
          imageUrl: '',
          tags: tags,
          updatedAt: DateTime.now());
      final imageUrl = await blogRemoteDataSource.uploadImage(image, blogModel);
      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final res = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(res);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      final res = await blogRemoteDataSource.getAllBlogs();
      return right(res);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
