import 'package:clean_architecture_demo/features/book/presentation/providers/book_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/book_item.dart';

class BookListScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(bookListProvider);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(bookListProvider),
        child: booksAsync.when(
          loading: () =>
              const Center(child: CircularProgressIndicator.adaptive()),
          error: (err, stack) => Center(child: Text('Error: $err')),
          data: (books) => ListView.separated(
            itemCount: books.length,
            separatorBuilder: (_, index) => const SizedBox(height: 10),
            itemBuilder: (_, index) {
              final book = books[index];
              return BookItem(book);
            },
          ),
        ),
      ),
    );
  }
}
