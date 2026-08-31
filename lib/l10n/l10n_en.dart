// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Library Management';

  @override
  String bookName(String nameOfTheBook) {
    return 'Name: $nameOfTheBook';
  }

  @override
  String bookAuthors(String authorsOfTheBook) {
    return 'Authors: $authorsOfTheBook';
  }

  @override
  String bookIsbn(String isbnOfTheBook) {
    return 'ISBN: $isbnOfTheBook';
  }

  @override
  String bookYear(int yearOfPublishing) {
    return 'Year: $yearOfPublishing';
  }
}
