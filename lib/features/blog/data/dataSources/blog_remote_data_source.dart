import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadImage(File image, BlogModel blog);
  Future<List<BlogModel>> getAllBlogs();
  Future<List<BlogModel>> getBlogsByUserId(String ownerId);
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;
  BlogRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await supabaseClient.from("blogs").insert(blog.toJson()).select();
      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<String> uploadImage(File image, BlogModel blog) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(blog.id, image);
      final res = await supabaseClient.storage
          .from('blog_images')
          .getPublicUrl(blog.id);
      return res;
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs =
          await supabaseClient.from('blogs').select('*, profiles (name)');
      return blogs
          .map((e) =>
              BlogModel.fromJson(e).copyWith(ownerName: e['profiles']['name']))
          .toList();
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getBlogsByUserId(String ownerId) async {
    try {
      final res = await supabaseClient
          .from('blogs')
          .select('*, profiles (name)')
          .eq('owner_id', ownerId);
      return res
          .map((e) =>
              BlogModel.fromJson(e).copyWith(ownerName: e['profiles']['name']))
          .toList();
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }
}
