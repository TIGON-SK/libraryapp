
class Authors {
  Authors({
    required this.authors,
  });

  List<Author> authors;

  factory Authors.fromJson(dynamic json) {
    List<Author> authors = [];
    if (json is List) {
      authors = json.map((authorsJson) => Author.fromJson(authorsJson)).toList();
    } else if (json is Map<String, dynamic>) {
      authors = List<Author>.from(json["authors"].map((x) => Author.fromJson
        (x)));
    }
    return Authors(authors: authors);
  }
}

class Author {
  String id = "";
  String name = "";
  String about = "";

  Author({required this.id, required this.name, required this.about});

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json["id"].toString(),
    name: json["name"].toString(),
    about: json["about"].toString(),);
}