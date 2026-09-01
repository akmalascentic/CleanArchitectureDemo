class Book {
  new({
    required this.id,
    required this.title,
    required this.author,
    required this.isbn,
    required this.publishedYear,
    required this.totalCopies,
    required this.availableCopies,
  });

  factory Book.empty() => Book(
    id: 0,
    title: '',
    author: '',
    isbn: '',
    publishedYear: 1970,
    totalCopies: 0,
    availableCopies: 0,
  );

  final int id;
  final String title;
  final String author;
  final String isbn;
  final int publishedYear;
  final int totalCopies;
  final int availableCopies;
}
