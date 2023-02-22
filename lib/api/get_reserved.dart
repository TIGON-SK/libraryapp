import 'bookUser_data.dart';
import 'book_data.dart';
import 'getBooksApi.dart';
import 'getBookUsersApi.dart';

class GetReserved {
  Map map = {};
  GetReserved(this.map);
  List<Book> lb = [];
  List<BookUser> lbu = [];

  Future<void> getAllBooks() async {
    BooksApi instance = BooksApi("");
    await instance.fetchBooks(map["obtainedToken"]);
    lb = instance.booksFetched;
  }

  Future<void> getAllBookUsers() async {
    BookUsersApi instance = BookUsersApi();
    await instance.fetchBookUsers(map["obtainedToken"]);
    lbu = instance.bookUsersFetched;
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