import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../api/book_data.dart';
import '../api/reserveBookApi.dart';

//     return AlertDialog(
//       title: Text('Popup Window'),
//       content: Text('This is the content of the popup window.'),
//       actions: [
//         TextButton(
//           child: Text('Close'),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ],
//     );

//showDialog(
//   context: context,
//   builder: (BuildContext context) {
//     return PopupWindow();
//   },
// );
class booksToExplore extends StatelessWidget {
  Future<List<Book>> listOfSelectedBooks;
  String token;
  int userId;
  booksToExplore(this.listOfSelectedBooks, this.userId, this.token, this
      .length);
  int length = 0;
  @override
  Widget build(BuildContext context) {
    String smallSentence(String bigSentence) {
      return bigSentence.substring(0, 15) + '...';
    }

    String trimTosmallerText(String text) {
      final length = text.length;
      int step = 30;
      int lastStep = 0;
      final numOfLines = 3;
      if (length <= step) {
        return text;
      }
      final buffer = StringBuffer();
      for (int i = 0; i < numOfLines; i++) {

        final line = text.substring(lastStep, (lastStep+step));
        lastStep+=step;
        (i+1==numOfLines)?buffer.write('${line.substring(0,line.length-4)}...')
            :buffer.write('$line\n');

      }
      return buffer.toString();
    }

    return FutureBuilder<List<Book>>(
      future: listOfSelectedBooks,
      builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          Center(child: Text("Nastala chyba"),);
        }

        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Card(
                child: SizedBox(
                  height: 220,
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        margin: EdgeInsets.all(20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            "http://10.0.2.2:8000/books/${snapshot.data![index]
                                .image}",
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return const Icon(
                                Icons.book,
                                size: 32.0,
                              );
                            },
                          ),
                        ),
                      ),
                      IntrinsicWidth(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: GestureDetector(
                                      child: Text(
                                          (snapshot.data![index].title
                                              .length > 15)
                                              ? smallSentence(
                                              snapshot.data![index].title)
                                              : snapshot.data![index]
                                              .title,
                                          style: const TextStyle(fontSize: 20)
                                      ),
                                      onTap: () {
                                       showToastx(
                                            snapshot.data![index].title);
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(1.0, 0.0),
                                    child: Text(snapshot.data![index]
                                        .release_year),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text(
                              snapshot.data![index].author,style: const
                              TextStyle(fontSize: 16)
                            ),],),
                            SizedBox(height: 10,),
                            Row(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text(
                                trimTosmallerText(snapshot.data![index].about),
                              ),],),
                            Row(
                              children: [
                                Text(
                                  "Počet kusov: ${snapshot.data![index]
                                      .count_available}",
                                  style: TextStyle(
                                      color: (snapshot.data![index]
                                          .count_available.toString() ==
                                          0.toString())
                                          ? Color.fromRGBO(255, 101, 81, 1.0)
                                          : Color.fromRGBO(63, 194, 163, 1.0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                SizedBox(width: 20),
                                Column(
                                  children: [
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      child: Text("Rezervovať"),
                                      style: ElevatedButton.styleFrom(
                                        primary: Color.fromRGBO(2, 180, 215, 1),
                                      ),
                                      onPressed: () {
                                        apiRequest(int.parse(
                                            snapshot.data![index].id));
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

    void apiRequest(int index) {
    ReserveBook reserveBook =
    ReserveBook(userId, index);
    reserveBook.reserve(token);
  }

  showToastx(fullTitle) {
    return Fluttertoast.showToast(
        msg: fullTitle,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white);
  }


}
