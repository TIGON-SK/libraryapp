class Books {
  Books({
    required this.books,
  });

  List<Book> books;

  factory Books.fromJson(dynamic json) {
    List<Book> books = [];
    if (json is List) {
      books = json.map((bookJson) => Book.fromJson(bookJson)).toList();
    } else if (json is Map<String, dynamic>) {
      books = List<Book>.from(json["books"].map((x) => Book.fromJson(x)));
    }
    return Books(books: books);
  }
}

class Book {
  String id = "";
  String title = "";
  String count_available = "";
  String about = "";
  String image = "";
  String release_year = "";
  String author = "";

  Book({required this.id, required this.title, required this.count_available,
    required this.about, required this.image, required this
      .release_year,
      required this.author});

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["id"].toString(),
    title: json["title"].toString(),
    count_available: json["count_available"].toString(),
    about: json["about"].toString(),
    image: json["image"].toString(),
    release_year: json["release_year"].toString(),
    author: "",);
}