import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../api/book_data.dart';
import '../api/get_reserved.dart';

class Profile extends StatefulWidget {
  Map map = {};

  Profile(this.map);

  @override
  ProfileState createState() => ProfileState(map);
}

class ProfileState extends State<Profile> {
  Map map = {};

  ProfileState(this.map);

  Color lentTextColor = Colors.black;
  Color reservedTextColor = Colors.black26;
  bool showLentBooks = true;
  bool allSetUp = false;

  Future<List<Book>>? reservedBooks;
  Future<List<Book>>? lentBooks;

  Future<void> setUp(gr) async {
    //tu je problem
    reservedBooks = Future.value(await gr.getUsersBooks("reserved"));
    lentBooks = Future.value(await gr.getUsersBooks("lended"));
  }

  @override
  void initState() {
    super.initState();
    GetReserved gr = GetReserved(map);
    setUp(gr).then((_) {
      if(mounted){
        setState(() {
          allSetUp = true;
        });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    String smallSentence(String bigSentence) {
      return bigSentence.substring(0, 15) + '...';
    }

    String s = map["userDataFetched"]["image"];
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bgImg/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(top: 30),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000.0),
                    child: Image.network(
                      s,
                      height: 150.0,
                      width: 150.0,
                    ),
                  ))),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Center(
                  child: Text(
                map["userDataFetched"]["name"].toString(),
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              )),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Center(
                  child: Text(
                map["userDataFetched"]["role"].toString(),
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              )),
              Padding(
                padding: EdgeInsets.only(top: 25),
              ),
            ]),
          ),
          SingleChildScrollView(
              child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 25),
              ),
              Column(
                children: [
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        child: Text(
                          'Požičané',
                          style: TextStyle(color: lentTextColor),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent)),
                        onPressed: allSetUp
                            ? () {
                                setState(() {
                                  reservedTextColor = Colors.black26;
                                  lentTextColor = Colors.black;
                                  showLentBooks = true;
                                });
                              }
                            : null,
                      ),
                      SizedBox(width: 10.0),
                      TextButton(
                        child: Text(
                          'Rezervované',
                          style: TextStyle(color: reservedTextColor),
                        ),
                        onPressed: allSetUp
                            ? () {
                                setState(() {
                                  reservedTextColor = Colors.black;
                                  lentTextColor = Colors.black26;
                                  showLentBooks = false;
                                });
                              }
                            : null,
                      ),
                    ],
                  ))
                ],
              ),
              FutureBuilder<List<Book>>(
                  future: (showLentBooks) ? lentBooks : reservedBooks,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return Text("Zatiaľ nemáte žiadne rezervované knihy");
                      }
                      return SingleChildScrollView(
                          child: Container(
                              child: Column(children: [
                        showLentBooks
                            ? Container(
                                child: Column(
                                children: [
                                  Text("Požičané knihy",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30)),
                                  ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: snapshot.data?.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                            return Container(
                                                margin: EdgeInsets.only(
                                                    left: 20, right: 20),
                                                child: Card(
                                                    child: SizedBox(
                                                      height: 150,
                                                      child: Row(

                                                        children: [
                                                          Container(
                                                              width: 70,
                                                              margin: EdgeInsets.all(20),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    10),
                                                                child: Image.network(
                                                                  "http://10.0.2.2:8000/boo"
                                                                      "ks/${snapshot.data![index].image}",

                                                                  errorBuilder:
                                                                      (BuildContext
                                                                  context,
                                                                      Object
                                                                      exception,
                                                                      StackTrace?
                                                                      stackTrace) {
                                                                    return const Icon(
                                                                      Icons.book,
                                                                      size: 32.0,
                                                                    );
                                                                  },
                                                                ),
                                                              )),
                                                          IntrinsicWidth(
                                                            child:
                                                            SizedBox(
                                                              width: 230,
                                                              child:Column
                                                              (children: [
                                                              SizedBox(height: 20,),
                                                              Row( mainAxisAlignment:
                                                              MainAxisAlignment.spaceBetween,children: [
                                                                // SizedBox(
                                                                //   height:20,
                                                                // ),
                                                                Align(
                                                                  alignment: Alignment
                                                                      .bottomLeft,
                                                                  child:
                                                                  GestureDetector(
                                                                    child: Text(
                                                                        (snapshot.data![index].title.length >
                                                                            15)
                                                                            ? smallSentence(snapshot
                                                                            .data![
                                                                        index]
                                                                            .title)
                                                                            : snapshot
                                                                            .data![
                                                                        index]
                                                                            .title,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            20)),
                                                                    onTap: () {
                                                                      showToastx(snapshot
                                                                          .data![
                                                                      index]
                                                                          .title);
                                                                    },
                                                                  ),
                                                                ),
                                                                // SizedBox(
                                                                //   height:10,
                                                                // ),

                                                                Align(
                                                                  alignment:
                                                                  Alignment(
                                                                      1.0, 0.0),
                                                                  child: Text(snapshot
                                                                      .data![index]
                                                                      .release_year),
                                                                ),
                                                              ],),
                                                              SizedBox(height: 10,),
                                                              Row(children: [Text
                                                                (trimTosmallerText(snapshot
                                                                  .data![index]
                                                                  .last_notification)==null?"Žiadna notifikácia pre túto knihu.":trimTosmallerText(snapshot
                                                                  .data![index]
                                                                  .last_notification),
                                                                style: TextStyle(color:
                                                                Color.fromRGBO(255, 109,
                                                                    4, 1),fontWeight:
                                                                FontWeight.bold),)
                                                                ,],)


                                                            ]),)

                                                          ),
                                                        ],
                                                      ),
                                                    )));
                                      })
                                ],
                              ))
                            : Container(
                                child: Column(children: [
                                Text("Rezervované knihy",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                                ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: snapshot.data?.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                          margin: EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Card(
                                              child: SizedBox(
                                            height: 150,
                                            child: Row(
                                              children: [
                                                Container(
                                                    width: 70,
                                                    margin: EdgeInsets.all(20),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.network(
                                                        "http://10.0.2.2:8000/boo"
                                                        "ks/${snapshot.data![index].image}",

                                                        errorBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Object
                                                                    exception,
                                                                StackTrace?
                                                                    stackTrace) {
                                                          return const Icon(
                                                            Icons.book,
                                                            size: 32.0,
                                                          );
                                                        },
                                                      ),
                                                    )),
                                                IntrinsicWidth(
                                                  child: SizedBox(
                                                    width: 230,
                                                    child:Column(children: [
                                                      SizedBox(height: 20,),
                                                      Row( mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          // SizedBox(
                                                          //   height:20,
                                                          // ),
                                                          Align(
                                                            alignment: Alignment
                                                                .bottomLeft,
                                                            child:
                                                            GestureDetector(
                                                              child: Text(
                                                                  (snapshot.data![index].title.length >
                                                                      15)
                                                                      ? smallSentence(snapshot
                                                                      .data![
                                                                  index]
                                                                      .title)
                                                                      : snapshot
                                                                      .data![
                                                                  index]
                                                                      .title,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                      20)),
                                                              onTap: () {
                                                                showToastx(snapshot
                                                                    .data![
                                                                index]
                                                                    .title);
                                                              },
                                                            ),
                                                          ),
                                                          // SizedBox(
                                                          //   height:10,
                                                          // ),

                                                          Align(
                                                            alignment:
                                                            Alignment(
                                                                1.0, 0.0),
                                                            child: Text(snapshot
                                                                .data![index]
                                                                .release_year),
                                                          ),
                                                        ],),
                                                      SizedBox(height: 10,),
                                                      Row(children: [Text
                                                        (trimTosmallerText(snapshot
                                                          .data![index]
                                                          .last_notification)=='null'?"Žiadna notifikácia pre túto knihu.":trimTosmallerText(snapshot
                                                          .data![index]
                                                          .last_notification),
                                                        style: TextStyle(color:
                                                        Color.fromRGBO(255, 109,
                                                            4, 1),fontWeight:
                                                        FontWeight.bold),)
                                                        ,],)


                                                    ]),
                                                  )

                                                ),
                                              ],
                                            ),
                                          )));
                                    })
                              ])),
                      ])));
                    } else {
                      if (!allSetUp) {}
                      return Center(
                          child: Column(children: [
                        SizedBox(
                          height: 20,
                        ),
                        CircularProgressIndicator()
                      ]));
                    }
                  }),
            ],
          ))
        ],
      ),
    ));
  }
  String trimTosmallerText(String text) {
    String s = "";
    int fakeLength = 0;
    int maxCharactersPerCard = 23;
    int lastPosition=0;
    List<String> words = [];
    for(var i=0;i<text.length;i++){
      if(text[i]==" "){
        words.add(text.substring(lastPosition,i));
        lastPosition=i;
      }

    }
    words.add(text.substring(lastPosition,text.length));
    //make words fit into card
    for(var i=0;i<words.length;i++){
      if(fakeLength>=maxCharactersPerCard){
        fakeLength=0;
       s+="\n";
        s += words[i].trim();
        fakeLength+=words[i].length;
      }
      else {
          s += words[i];
          fakeLength += words[i].length;
      }
    }
    return s;
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
