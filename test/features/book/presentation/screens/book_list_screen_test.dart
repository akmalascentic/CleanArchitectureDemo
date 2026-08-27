import 'package:clean_architecture_demo/core/error/failures.dart';
import 'package:clean_architecture_demo/features/book/domain/entities/book.dart';
import 'package:clean_architecture_demo/features/book/presentation/providers/book_list_provider.dart';
import 'package:clean_architecture_demo/features/book/presentation/screens/book_list_screen.dart';
import 'package:clean_architecture_demo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../helpers/book_fixtures.dart';

Widget buildSubject(FakeBookRepository repository) {
  return ProviderScope(
    overrides: [bookRepositoryProvider.overrideWithValue(repository)],
    child: MaterialApp(
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: BookListScreen(),
    ),
  );
}

void main() {
  testWidgets('shows a loading indicator while books are loading', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildSubject(
        FakeBookRepository(Right<Failure, List<Book>>([sampleBook])),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows localized book items when loading succeeds', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildSubject(
        FakeBookRepository(Right<Failure, List<Book>>([sampleBook])),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Name: Clean Code'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is RichText &&
            widget.text.toPlainText().contains('Authors: Robert C. Martin'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('shows an error message when loading fails', (tester) async {
    await tester.pumpWidget(
      buildSubject(FakeBookRepository(Left(CacheFailure()))),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Error: Exception:'), findsOneWidget);
  });
}
