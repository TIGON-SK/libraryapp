import 'book_data.dart';

class getPopular {
  List<Book> allBooks;
  late int topx = 5;
  late List<Book> topxbooks = [];
  late int position = 0;

  getPopular(this.allBooks);

  void pickBestBooks() {
    Book currentBook = Book(
        id: "-1",
        title: "",
        count_available: "",
        about: "",
        image: "",
        release_year: "",
        author: "",
        reads_count: "",
        last_notification: '');
    int maxReads = 0;
    for (var i = 0; i < allBooks.length; i++) {
      if (int.parse(allBooks[i].reads_count) > maxReads) {
        maxReads = int.parse(allBooks[i].reads_count);
        currentBook = allBooks[i];
      }
      if (i == allBooks.length - 1) {
        for (var j = 0; j < topx; j++) {
          topxbooks.add(currentBook);
          allBooks.remove(currentBook);
          position++;
          if (position <= topx - 1) {
            pickBestBooks();
          }
        }
      }
    }
    topxbooks=topxbooks.toSet().toList();

  }
}