part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUploadEvent extends BlogEvent {
  final String ownerId;
  final String title;
  final String content;
  final List<String> tags;
  final File image;
  BlogUploadEvent({
    required this.ownerId,
    required this.title,
    required this.content,
    required this.tags,
    required this.image,
  });
}

final class GetAllBlogsEvent extends BlogEvent {}

final class GetBlogsByUserIdEvent extends BlogEvent {
  final String ownerId;
  GetBlogsByUserIdEvent({required this.ownerId});
}
