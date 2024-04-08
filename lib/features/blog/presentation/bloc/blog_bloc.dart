import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/useCase/use_case.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/useCases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/useCases/get_blogs_by_user_id.dart';
import 'package:blog_app/features/blog/domain/useCases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  final GetBlogsByUserId _getBlogsByUserId;
  BlogBloc(
      {required UploadBlog uploadBlog,
      required GetAllBlogs getAllBlogs,
      required GetBlogsByUserId getBlogsByUserId})
      : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        _getBlogsByUserId = getBlogsByUserId,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      print(emit);
      print(event.toString());
      emit(BlogLoading());
    });
    on<BlogUploadEvent>(_onBlogUpload);
    on<GetAllBlogsEvent>(_onGetAllBlogs);
    on<GetBlogsByUserIdEvent>(_onGetBlogsByUserId);
  }
  _onGetBlogsByUserId(
      GetBlogsByUserIdEvent event, Emitter<BlogState> emit) async {
    final res = await _getBlogsByUserId.call(event.ownerId);
    return res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogFetchByUserIdSuccess(r)),
    );
  }

  _onGetAllBlogs(GetAllBlogsEvent event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogs.call(NoParams());
    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogFetchSuccess(r)),
    );
  }

  _onBlogUpload(BlogUploadEvent event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog.call(UploadBlogParams(
        ownerId: event.ownerId,
        title: event.title,
        content: event.content,
        tags: event.tags,
        image: event.image));
    return res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogUploadSuccess()),
    );
  }
}
