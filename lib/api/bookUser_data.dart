class BookUser {
  final String id;
  final String user_id;
  final String book_id;
  final String type;

  const BookUser({
    required this.id,
    required this.user_id,
    required this.book_id,
    required this.type,
  });

  factory BookUser.fromJson(Map<String, dynamic> json) => BookUser(
      id: json["id"].toString(),
      user_id: json["user_id"].toString(),
      book_id: json["book_id"].toString(),
      type: json["type"].toString());
}

class BookUsers {
  List<BookUser> bookUsers = [];

  BookUsers({required this.bookUsers});

  factory BookUsers.fromJson(Map<String, dynamic> json) => BookUsers(
    bookUsers: List<BookUser>.from(
      json["book"].map((x) => BookUser.fromJson(x)),
    ),
  );
}