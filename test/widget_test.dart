import 'package:clean_architecture_demo/main.dart';
import 'package:clean_architecture_demo/features/book/presentation/screens/book_list_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('starts the library application', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: LibraryApp()));
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();

    expect(find.byType(BookListScreen), findsOneWidget);
  });
}
