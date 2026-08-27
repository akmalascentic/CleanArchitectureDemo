import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/book_model.dart';

abstract class BookLocalDataSource {
  Future<List<BookModel>> getBooks();
}

class BookLocalDatasourceImpl implements BookLocalDataSource {
  @override
  Future<List<BookModel>> getBooks() async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 800));

    final raw = await rootBundle.loadString('assets/data/books.json');
    final List<dynamic> jsonList = json.decode(raw) as List<dynamic>;

    return jsonList
        .map((e) => BookModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
