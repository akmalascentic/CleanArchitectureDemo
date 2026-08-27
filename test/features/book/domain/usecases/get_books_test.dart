import 'package:clean_architecture_demo/core/error/failures.dart';
import 'package:clean_architecture_demo/core/usecase/usecase.dart';
import 'package:clean_architecture_demo/features/book/domain/entities/book.dart';
import 'package:clean_architecture_demo/features/book/domain/usecases/get_books.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/book_fixtures.dart';

void main() {
  test('delegates to the repository and returns its result', () async {
    final expected = Right<Failure, List<Book>>([sampleBook]);
    final repository = FakeBookRepository(expected);
    final useCase = GetBooks(repository);

    final result = await useCase(const NoParams());

    expect(repository.getBooksCallCount, 1);
    expect(result, same(expected));
  });
}
