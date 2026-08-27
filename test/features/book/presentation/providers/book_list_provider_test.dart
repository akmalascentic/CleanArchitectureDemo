import 'package:clean_architecture_demo/core/error/failures.dart';
import 'package:clean_architecture_demo/features/book/data/datasources/book_local_datasource.dart';
import 'package:clean_architecture_demo/features/book/data/repositories/book_repository_impl.dart';
import 'package:clean_architecture_demo/features/book/domain/entities/book.dart';
import 'package:clean_architecture_demo/features/book/domain/usecases/get_books.dart';
import 'package:clean_architecture_demo/features/book/presentation/providers/book_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../helpers/book_fixtures.dart';

void main() {
  group('book providers', () {
    test('wire the local data source through the repository and use case', () {
      final dataSource = FakeBookLocalDataSource(
        getBooksResult: () async => [sampleBookModel],
      );
      final container = ProviderContainer(
        overrides: [bookLocalDataSourceProvider.overrideWithValue(dataSource)],
      );
      addTearDown(container.dispose);

      expect(container.read(bookRepositoryProvider), isA<BookRepositoryImpl>());
      expect(container.read(getBooksUseCaseProvider), isA<GetBooks>());
    });

    test('exposes books returned by the use case', () async {
      final repository = FakeBookRepository(
        Right<Failure, List<Book>>([sampleBook]),
      );
      final container = ProviderContainer(
        overrides: [bookRepositoryProvider.overrideWithValue(repository)],
      );
      final subscription = container.listen(bookListProvider, (_, _) {});
      addTearDown(subscription.close);
      addTearDown(container.dispose);

      final books = await container.read(bookListProvider.future);

      expect(books, [sampleBook]);
      expect(repository.getBooksCallCount, 1);
    });

    test('retains the failure while retrying a failed request', () async {
      final container = ProviderContainer(
        overrides: [
          bookRepositoryProvider.overrideWithValue(
            FakeBookRepository(Left(CacheFailure())),
          ),
        ],
      );
      final subscription = container.listen(bookListProvider, (_, _) {});
      addTearDown(subscription.close);
      addTearDown(container.dispose);

      await Future<void>.delayed(Duration.zero);

      final state = container.read(bookListProvider);
      expect(state, isA<AsyncLoading<List<Book>>>());
      expect(state.hasError, isTrue);
      expect(state.error, isA<Exception>());
    });
  });
}
