import 'package:clean_architecture_demo/features/book/data/models/book_model.dart';
import 'package:clean_architecture_demo/features/book/domain/entities/book.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const json = {
    'id': 1,
    'title': 'Clean Code',
    'author': 'Robert C. Martin',
    'isbn': '9780132350884',
    'publishedYear': 2008,
    'totalCopies': 7,
    'availableCopies': 4,
  };

  group('BookModel', () {
    test('creates a model from JSON', () {
      final model = BookModel.fromJson(json);

      expect(model, isA<Book>());
      expect(model.id, 1);
      expect(model.title, 'Clean Code');
      expect(model.author, 'Robert C. Martin');
      expect(model.isbn, '9780132350884');
      expect(model.publishedYear, 2008);
      expect(model.totalCopies, 7);
      expect(model.availableCopies, 4);
    });

    test('serializes every property to JSON', () {
      final model = BookModel.fromJson(json);

      expect(model.toJson(), json);
    });
  });
}
