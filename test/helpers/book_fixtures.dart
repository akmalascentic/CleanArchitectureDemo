import 'package:clean_architecture_demo/core/error/failures.dart';
import 'package:clean_architecture_demo/features/book/data/datasources/book_local_datasource.dart';
import 'package:clean_architecture_demo/features/book/data/models/book_model.dart';
import 'package:clean_architecture_demo/features/book/domain/entities/book.dart';
import 'package:clean_architecture_demo/features/book/domain/repositories/book_repository.dart';
import 'package:fpdart/fpdart.dart';

final sampleBook = Book(
  id: 1,
  title: 'Clean Code',
  author: 'Robert C. Martin',
  isbn: '9780132350884',
  publishedYear: 2008,
  totalCopies: 7,
  availableCopies: 4,
);

final sampleBookModel = BookModel(
  id: 1,
  title: 'Clean Code',
  author: 'Robert C. Martin',
  isbn: '9780132350884',
  publishedYear: 2008,
  totalCopies: 7,
  availableCopies: 4,
);

class FakeBookLocalDataSource implements BookLocalDataSource {
  FakeBookLocalDataSource({required this.getBooksResult});

  final Future<List<BookModel>> Function() getBooksResult;

  @override
  Future<List<BookModel>> getBooks() => getBooksResult();
}

class FakeBookRepository implements BookRepository {
  FakeBookRepository(this.result);

  Either<Failure, List<Book>> result;
  var getBooksCallCount = 0;

  @override
  Future<Either<Failure, List<Book>>> getBooks() async {
    getBooksCallCount++;
    return result;
  }
}
