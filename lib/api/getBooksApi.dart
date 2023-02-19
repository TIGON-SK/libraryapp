import 'dart:convert';
import 'package:http/http.dart' as http;
import 'authorBook_data.dart';
import 'author_data.dart';
import 'book_data.dart';

class BooksApi {
  BooksApi(this.parameter);

  String parameter;
  List<Book> booksFetched = [];

  Future<void> fetchBooks(token) async {
    final responseBooks = await http.get(Uri.parse('http://10.0.2'
        '.2:8000/api/books'),
        headers: {'Authorization': "Bearer " + token});
    final responseAuthorBook = await http.post(Uri.parse('http://10.0.2'
        '.2:8000/api/getAuthorBooks'),
        headers: {'Authorization': "Bearer " + token});
    final responseAuthors = await http.get(Uri.parse('http://10.0.2'
        '.2:8000/api/authors'),
        headers: {'Authorization': "Bearer " + token});
    if (responseBooks.body.isNotEmpty) {
      Books booksDecoded = Books.fromJson(jsonDecode(responseBooks.body));
      AuthorBooks authorBooks = AuthorBooks.fromJson(jsonDecode(responseAuthorBook.body));
      Authors authors = Authors.fromJson(jsonDecode(responseAuthors.body));
      for (int i = 0; i < authorBooks.authorBooks.length; i++) {
        for (int j = 0; j < booksDecoded.books.length; j++) {
          if(authorBooks.authorBooks[i].book_id==booksDecoded.books[j].id){
            for (int k = 0; k < authors.authors.length; k++) {
              if(authors.authors[k].id==authorBooks.authorBooks[i].author_id){
                booksDecoded.books[j].author = authors.authors[k].name;
              }
            }
          }
        }
      }
      if (responseBooks.statusCode == 200) {
        booksFetched = booksDecoded.books;
      } else {
        throw Exception('Failed to load books');
      }
    }
  }

  Future<void> fetchSearchedBooks(token) async {
    final response = await http.get(
        Uri.parse('http://10.0.2'
            '.2:8000/api/search?search=${parameter}'),
        headers: {'Authorization': "Bearer " + token});
    if (response.body.isNotEmpty) {
      Books booksDecoded = Books.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        booksFetched = booksDecoded.books;
      } else {
        throw Exception('Failed to load books');
      }
    }
  }
}
