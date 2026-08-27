import 'package:clean_architecture_demo/features/book/data/datasources/book_local_datasource.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('loads and maps the bundled book catalogue', () async {
    final books = await BookLocalDatasourceImpl().getBooks();

    expect(books, hasLength(50));
    expect(books.first.id, 1);
    expect(books.first.title, 'Clean Code');
    expect(books.first.availableCopies, 4);
    expect(books.last.id, 50);
  });
}
