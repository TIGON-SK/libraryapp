import 'dart:async';
import 'package:flutter/material.dart';
import '../api/book_data.dart';
import '../api/getBooksApi.dart';
import '../api/reserveBookApi.dart';
import 'booksToExplore.dart';

class Explore extends StatefulWidget {
  Map map = {};
  bool loading;
  bool filledParams;

  Explore(this.map, this.loading, this.filledParams);

  @override
  ExploreState createState() => ExploreState(map, loading, filledParams);
}

class ExploreState extends State<Explore> {
  bool _isMounted = false;

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  String token = "";
  TextEditingController searchController = new TextEditingController();
  Map dataWToken = {};
  bool filledParams;
  String showBooksWithTitle = "";

  ExploreState(this.dataWToken, this.loading, this.filledParams);

  bool loading = true;
  bool started = false;
  bool error = false;
  Widget currentWidget = Container();
  Future<List<Book>>? booksList;

  void loadingReset() {
    setState(() {
      loading = true;
    });
  }

  Future<List<Book>> setUpBooks(parameter) async {
    BooksApi instance = BooksApi(parameter);
    if (parameter == "") {
      await instance.fetchBooks(dataWToken["obtainedToken"]);
      loading = false;
      return instance.booksFetched;
    }
    await instance.fetchSearchedBooks(dataWToken["obtainedToken"]);
    loading = false;
    return instance.booksFetched;
  }

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    try {
      setUpBooks("").then((books) {
        if (_isMounted) {
          currentWidget = booksToExplore(
            Future.value(books),
            dataWToken["userDataFetched"]["id"],
            dataWToken["obtainedToken"],
            books.length,
          );
          setState(() {
            loading = false;
            started = true;
          });
        }
      });
    } catch (e) {
      error = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if(error){
      return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "Skontrolujte pripojenie k "
                        "internetu :/",
                    style: TextStyle(color: Colors.red.withOpacity(0.6))),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(2, 180, 215, 1),
                    ),
                    onPressed: loadingReset,
                    child: Text('Retry'))
              ]));
    }
    if (!loading) {
      if (started) {
        return SingleChildScrollView(
            child: Container(
                child: Column(children: [
                  Padding(padding: EdgeInsets.only(top: 50)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                          color: Color(0xFFF9D276),
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(211, 211, 211, 1.0),
                                spreadRadius: 4,
                                blurRadius: 10)
                          ]),
                      child: TextField(
                        controller: searchController,
                        onChanged: (String text) {
                          setUpBooks(text).then((books) {
                            currentWidget = booksToExplore(
                              Future.value(books),
                              dataWToken["userDataFetched"]["id"],
                              dataWToken["obtainedToken"],
                              books.length,
                            );
                            setState(() {
                              loading = false;
                              started = true;
                            });
                          });
                        },
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: BorderSide.none),
                            hintText: 'Hľadaj knihy',
                            hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 18),
                            prefixIcon: Container(
                              padding: EdgeInsets.all(15),
                              child: Icon(Icons.search),
                              width: 18,
                            )),
                      )),
                  this.currentWidget
                ])));
      }
    }

    return const Center(child: CircularProgressIndicator());
  }

  void apiRequest(int index) {
    ReserveBook reserveBook =
    ReserveBook(dataWToken["userDataFetched"]["id"], index);
    reserveBook.reserve(dataWToken["obtainedToken"]);
  }

}
