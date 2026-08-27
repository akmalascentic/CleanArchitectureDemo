import 'package:clean_architecture_demo/features/book/data/datasources/book_local_datasource.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/book.dart';
import '../widgets/book_item.dart';

class VanillaBookListScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<VanillaBookListScreen> createState() => _VanillaBookListScreen();
}

class _VanillaBookListScreen extends State<VanillaBookListScreen> {
  final BookLocalDataSource _bookDataSource = BookLocalDatasourceImpl();
  late Future<List<Book>> _booksFuture;

  @override
  void initState() {
    super.initState();
    _booksFuture = _bookDataSource.getBooks();
  }

  Future<void> _refresh() async {
    setState(() {
      _booksFuture = _bookDataSource.getBooks();
    });
    await _booksFuture;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: RefreshIndicator.noSpinner(
      onRefresh: _refresh,
      child: FutureBuilder<List<Book>>(
        future: _booksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final books = snapshot.data ?? [];
          return ListView.separated(
            itemCount: books.length,
            separatorBuilder: (_, index) => const SizedBox(height: 10),
            itemBuilder: (_, index) {
              final book = books[index];
              return BookItem(
                title: book.title,
                author: book.author,
                isbn: book.isbn,
              );
            },
          );
        },
      ),
    ),
  );
}
