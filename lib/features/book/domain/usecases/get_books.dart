import 'package:clean_architecture_demo/core/error/failures.dart';
import 'package:clean_architecture_demo/core/usecase/usecase.dart';
import 'package:clean_architecture_demo/features/book/domain/entities/book.dart';
import 'package:clean_architecture_demo/features/book/domain/repositories/book_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetBooks implements UseCase<List<Book>, NoParams> {
  new(this.repository);

  final BookRepository repository;

  @override
  Future<Either<Failure, List<Book>>> call(NoParams params) =>
      repository.getBooks();
}
