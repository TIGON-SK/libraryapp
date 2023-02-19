class AuthorBook {
  String id = "";
  String author_id = "";
  String book_id = "";

  AuthorBook({required this.id, required this.author_id, required this.book_id,});

  factory AuthorBook.fromJson(Map<String, dynamic> json) => AuthorBook(
    id: json["id"].toString(),
    author_id: json["author_id"].toString(),
    book_id: json["book_id"].toString(),
  );
}
class AuthorBooks {
  AuthorBooks({
    required this.authorBooks,
  });

  List<AuthorBook> authorBooks;

  factory AuthorBooks.fromJson(dynamic json) {
    List<AuthorBook> authorBooks = [];
    if (json is List) {
      authorBooks = json.map((authorJson) => AuthorBook.fromJson(authorJson))
          .toList();
    } else if (json is Map<String, dynamic>) {
      authorBooks = List<AuthorBook>.from(json["authorBooks"].map((x) =>
          AuthorBook.fromJson(x)));
    }
    return AuthorBooks(authorBooks: authorBooks);
  }
}