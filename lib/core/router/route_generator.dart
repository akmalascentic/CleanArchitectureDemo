import 'package:clean_architecture_demo/features/book/domain/entities/book.dart';
import 'package:clean_architecture_demo/features/book/presentation/screens/book_details_screen.dart';
import 'package:clean_architecture_demo/features/book/presentation/screens/book_list_screen.dart';
import 'package:flutter/material.dart';

final class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) =>
      switch (settings.name) {
        '/' => MaterialPageRoute(builder: (_) => const BookListScreen()),
        '/details' => MaterialPageRoute(
          builder: (_) => settings.arguments is Book
              ? BookDetailsScreen(book: settings.arguments as Book)
              : const _ErrorScreen(),
        ),
        _ => MaterialPageRoute(builder: (_) => const _ErrorScreen()),
      };
}

class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Error')),
    body: Center(child: Text('ERROR')),
  );
}
