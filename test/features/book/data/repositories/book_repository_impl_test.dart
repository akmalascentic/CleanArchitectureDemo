import 'package:clean_architecture_demo/core/error/failures.dart';
import 'package:clean_architecture_demo/features/book/data/models/book_model.dart';
import 'package:clean_architecture_demo/features/book/data/repositories/book_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/book_fixtures.dart';

void main() {
  group('BookRepositoryImpl', () {
    test('returns books from the local data source', () async {
      final repository = BookRepositoryImpl(
        FakeBookLocalDataSource(getBooksResult: () async => [sampleBookModel]),
      );

      final result = await repository.getBooks();

      result.match((failure) => fail('Expected books, but received $failure'), (
        books,
      ) {
        expect(books, hasLength(1));
        expect(books.single.title, sampleBook.title);
      });
    });

    test('returns CacheFailure when the local data source throws', () async {
      final repository = BookRepositoryImpl(
        FakeBookLocalDataSource(
          getBooksResult: () =>
              Future<List<BookModel>>.error(Exception('disk')),
        ),
      );

      final result = await repository.getBooks();

      result.match(
        (failure) => expect(failure, isA<CacheFailure>()),
        (books) => fail('Expected a failure, but received $books'),
      );
    });
  });
}
