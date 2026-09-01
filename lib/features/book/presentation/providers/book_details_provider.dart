import 'package:clean_architecture_demo/features/book/domain/entities/book.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_details_provider.g.dart';

// READ-ONLY Provider
// @riverpod
// Future<Book> bookDetails(Ref ref, int id) async {
//   await Future.delayed(const Duration(seconds: 2));
//   return Book.empty();
// }

@riverpod
class BookDetails extends _$BookDetails {
  @override
  Future<Book> build(int id) async {
    await Future.delayed(const Duration(seconds: 2));
    return Book.empty();
  }

  void mutateBook() {
    state = AsyncData(
      Book(
        id: 1,
        title: 'C++',
        author: 'John',
        isbn: '1111',
        publishedYear: 2020,
        totalCopies: 10,
        availableCopies: 9,
      ),
    );
  }
}
