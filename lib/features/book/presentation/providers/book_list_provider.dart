import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/usecase/usecase.dart';
import '../../data/datasources/book_local_datasource.dart';
import '../../data/repositories/book_repository_impl.dart';
import '../../domain/entities/book.dart';
import '../../domain/repositories/book_repository.dart';
import '../../domain/usecases/get_books.dart';

part 'book_list_provider.g.dart';

@riverpod
BookLocalDataSource bookLocalDataSource(Ref ref) => BookLocalDatasourceImpl();

@riverpod
BookRepository bookRepository(Ref ref) =>
    BookRepositoryImpl(ref.read(bookLocalDataSourceProvider));

@riverpod
GetBooks getBooksUseCase(Ref ref) => GetBooks(ref.read(bookRepositoryProvider));

@riverpod
class BookList extends _$BookList {
  @override
  Future<List<Book>> build() async {
    final useCase = ref.read(getBooksUseCaseProvider);
    final result = await useCase(const NoParams());

    return result.match(
      (failure) => throw Exception(failure),
      (products) => products,
    );
  }
}
