import 'package:clean_architecture_demo/features/book/domain/entities/book.dart';
import 'package:clean_architecture_demo/features/book/presentation/widgets/book_item.dart';
import 'package:clean_architecture_demo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('displays localized book details', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        home: Scaffold(
          body: BookItem(
            Book(
              id: 1,
              title: 'Clean Code',
              author: 'Robert C. Martin',
              isbn: '9780132350884',
              publishedYear: 2024,
              totalCopies: 2,
              availableCopies: 1,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Name: Clean Code'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is RichText &&
            widget.text.toPlainText().contains('Authors: Robert C. Martin'),
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is RichText &&
            widget.text.toPlainText().contains('ISBN: 9780132350884'),
      ),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.menu_book), findsOneWidget);
  });
}
