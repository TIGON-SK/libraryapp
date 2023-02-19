import 'bookUser_data.dart';
import 'book_data.dart';
import 'getBooksApi.dart';
import 'getBookUsersApi.dart';

class GetReserved {
  Map map = {};

  GetReserved(this.map);

  List<Book> lb = [];
  List<BookUser> lbu = [];

  Future<List<Book>> getAllBooks() async {
    BooksApi instance = BooksApi("");
    await instance.fetchBooks(map["obtainedToken"]);
    lb = instance.booksFetched;
    return instance.booksFetched;
  }

  Future<List<BookUser>> getAllBookUsers() async {
    BookUsersApi instance = BookUsersApi();
    await instance.fetchBookUsers(map["obtainedToken"]);
    lbu = instance.bookUsersFetched;
    return instance.bookUsersFetched;
  }

  Future<List<Book>> getUsersBooks(String state) async {
    await getAllBooks();
    await getAllBookUsers();
    List<int> ids = [];
    for (var i = 0; i < lbu.length; i++) {
      if ((lbu[i].user_id.toString() ==
          map["userDataFetched"]["id"].toString()) && lbu[i].type==state) {
        ids.add(int.parse(lbu[i].book_id));
      }
    }
    List<Book> books = [];
    for (var i = 0; i < lb.length; i++) {
      for (var j = 0; j < ids.length; j++) {
        if (lb[i].id.toString() == ids[j].toString()) {
          books.add(lb[i]);
        }
      }
    }
    return books;
  }
}