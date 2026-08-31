import 'package:clean_architecture_demo/core/extensions/context_extensions.dart';
import 'package:clean_architecture_demo/features/book/domain/entities/book.dart';
import 'package:flutter/material.dart';

class BookDetailsScreen extends StatelessWidget {
  const new({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(centerTitle: true, title: Text(book.title)),
    body: Column(
      crossAxisAlignment: .start,
      children: [
        Text(context.l10n.bookAuthors(book.author)),
        Text(context.l10n.bookIsbn(book.isbn)),
        Text(context.l10n.bookYear(book.publishedYear)),
      ],
    ),
  );
}
