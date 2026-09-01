import 'package:clean_architecture_demo/core/extensions/context_extensions.dart';
import 'package:clean_architecture_demo/features/book/domain/entities/book.dart';
import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  const new(this.book, {super.key});

  final Book book;

  @override
  Widget build(BuildContext context) => Card(
    elevation: 0,
    margin: .zero,
    shape: RoundedRectangleBorder(borderRadius: .zero),
    child: InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/details', arguments: book.id);
        // Navigator.pushNamed(context, '/details');
      },
      child: Padding(
        padding: .all(10),
        child: Row(
          spacing: 10,
          children: [
            CircleAvatar(child: Icon(Icons.menu_book)),
            Flexible(
              child: Column(
                spacing: 6,
                crossAxisAlignment: .start,
                children: [
                  Text(
                    context.l10n.bookName(book.title),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  _InfoLabel(
                    icon: Icon(Icons.mode_edit_outlined, size: 16),
                    label: context.l10n.bookAuthors(book.author),
                  ),
                  _InfoLabel(
                    icon: Icon(Icons.qr_code_2, size: 16),
                    label: context.l10n.bookIsbn(book.isbn),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _InfoLabel extends StatelessWidget {
  const new({required this.icon, required this.label});

  final Widget icon;
  final String label;

  @override
  Widget build(BuildContext context) => RichText(
    text: TextSpan(
      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: .bold),
      children: [
        WidgetSpan(child: icon, alignment: .middle),
        const WidgetSpan(child: SizedBox(width: 4)),
        TextSpan(text: label),
      ],
    ),
  );
}
