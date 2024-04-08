import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/useCase/use_case.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class GetBlogsByUserId implements UseCase<List<Blog>, String> {
  final BlogRepository blogRepository;
  GetBlogsByUserId(this.blogRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(String params) {
    return blogRepository.getBlogsByUserId(params);
  }
}
