import 'dart:async';

import 'package:flutter/material.dart';

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
    reservedBooks = Future.value(await gr.getUsersBooks("reserved"));
    lentBooks = Future.value(await gr.getUsersBooks("lended"));
  }

  @override
  void initState() {
    super.initState();
    GetReserved gr = GetReserved(map);
    setUp(gr).then((_) {
      setState(() {
        allSetUp = true;
      });
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
              Column(children: [Container(
                  child: Row(
                    children: <Widget>[
                      TextButton(
                        child: Text('Požičané',style: TextStyle
                          (color:lentTextColor),),
                        style:ButtonStyle(backgroundColor:
                        MaterialStateProperty.all(Colors.transparent)),
                        onPressed: () {
                          setState(() {
                            reservedTextColor=Colors.black26;
                            lentTextColor=Colors.black;
                            showLentBooks=true;
                          });
                        },
                      ),
                      SizedBox(width: 10.0),
                      TextButton(
                        child: Text('Rezervované',style: TextStyle
                          (color:reservedTextColor),),
                        onPressed: () {
                          setState(() {
                            reservedTextColor=Colors.black;
                            lentTextColor=Colors.black26;
                            showLentBooks=false;
                          });
                        },
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ))],),
              FutureBuilder<List<Book>>(
                  future: (showLentBooks)?lentBooks:reservedBooks,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if(snapshot.data!.isEmpty){
                        return Text("Zatiaľ nemáte žiadne rezervované knihy");
                      }
                      return SingleChildScrollView(
                          child: Container(
                              child: Column(children: [
                        showLentBooks ? Container(child:Column(children: [
                          Text("Požičané knihy",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30)),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    margin: EdgeInsets.only(left: 20, right: 20),
                                    child: Card(
                                        child: SizedBox(
                                          height: 100,
                                          child: Row(
                                            children: [
                                              Container(
                                                  width: 70,
                                                  margin: EdgeInsets.all(20),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(8.0),
                                                    child: Image.network(
                                                      "http://10.0.2.2:8000/boo"
                                                          "ks/${snapshot.data![index].image}",
                                                      errorBuilder: (BuildContext
                                                      context,
                                                          Object exception,
                                                          StackTrace? stackTrace) {
                                                        return const Icon(
                                                          Icons.book,
                                                          size: 32.0,
                                                        );
                                                      },
                                                    ),
                                                  )),
                                              IntrinsicWidth(
                                                child: Column(children: [
                                                  Container(
                                                      padding:
                                                      EdgeInsets.only(top: 10),
                                                      height: 50,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          // SizedBox(
                                                          //   height:20,
                                                          // ),
                                                          Align(
                                                            alignment:
                                                            Alignment.bottomLeft,
                                                            child: GestureDetector(
                                                              child: Text(
                                                                  (snapshot
                                                                      .data![
                                                                  index]
                                                                      .title
                                                                      .length >
                                                                      15)
                                                                      ? smallSentence(
                                                                      snapshot
                                                                          .data![
                                                                      index]
                                                                          .title)
                                                                      : snapshot
                                                                      .data![
                                                                  index]
                                                                      .title,
                                                                  style: TextStyle(
                                                                      fontSize: 20)),
                                                              onTap: () {
                                                                //showToastx
                                                                (snapshot
                                                                    .data![index]
                                                                    .title);
                                                              },
                                                            ),
                                                          ),
                                                          // SizedBox(
                                                          //   height:10,
                                                          // ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Align(
                                                            alignment:
                                                            Alignment(1.0, 0.0),
                                                            child: Text(snapshot
                                                                .data![index]
                                                                .release_year),
                                                          ),
                                                        ],
                                                      )),
                                                ]),
                                              ),

                                              // Padding(
                                              //     padding: EdgeInsets.only(bottom: 20),
                                              //     child: Column(
                                              //       children: [
                                              //         Padding(
                                              //           padding: EdgeInsets.all(5),
                                              //           //apply padding to all four sides
                                              //           child: Text("Počet kusov na "
                                              //               "sklade:${snapshot.data![index].count_available}"),
                                              //         ),
                                              //
                                              //       ],
                                              //     ))
                                            ],
                                          ),
                                        )));
                              })
                        ],))
                            :Container
                          (child:Column(children:[
                            Text("Rezervované knihy",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30)),
                            ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: snapshot.data?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                      margin: EdgeInsets.only(left: 20, right: 20),
                                      child: Card(
                                          child: SizedBox(
                                            height: 100,
                                            child: Row(
                                              children: [
                                                Container(
                                                    width: 70,
                                                    margin: EdgeInsets.all(20),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(8.0),
                                                      child: Image.network(
                                                        "http://10.0.2.2:8000/boo"
                                                            "ks/${snapshot.data![index].image}",
                                                        errorBuilder: (BuildContext
                                                        context,
                                                            Object exception,
                                                            StackTrace? stackTrace) {
                                                          return const Icon(
                                                            Icons.book,
                                                            size: 32.0,
                                                          );
                                                        },
                                                      ),
                                                    )),
                                                IntrinsicWidth(
                                                  child: Column(children: [
                                                    Container(
                                                        padding:
                                                        EdgeInsets.only(top: 10),
                                                        height: 50,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            // SizedBox(
                                                            //   height:20,
                                                            // ),
                                                            Align(
                                                              alignment:
                                                              Alignment.bottomLeft,
                                                              child: GestureDetector(
                                                                child: Text(
                                                                    (snapshot
                                                                        .data![
                                                                    index]
                                                                        .title
                                                                        .length >
                                                                        15)
                                                                        ? smallSentence(
                                                                        snapshot
                                                                            .data![
                                                                        index]
                                                                            .title)
                                                                        : snapshot
                                                                        .data![
                                                                    index]
                                                                        .title,
                                                                    style: TextStyle(
                                                                        fontSize: 20)),
                                                                onTap: () {
                                                                  //showToastx
                                                                  (snapshot
                                                                      .data![index]
                                                                      .title);
                                                                },
                                                              ),
                                                            ),
                                                            // SizedBox(
                                                            //   height:10,
                                                            // ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Align(
                                                              alignment:
                                                              Alignment(1.0, 0.0),
                                                              child: Text(snapshot
                                                                  .data![index]
                                                                  .release_year),
                                                            ),
                                                          ],
                                                        )),
                                                  ]),
                                                ),

                                                // Padding(
                                                //     padding: EdgeInsets.only(bottom: 20),
                                                //     child: Column(
                                                //       children: [
                                                //         Padding(
                                                //           padding: EdgeInsets.all(5),
                                                //           //apply padding to all four sides
                                                //           child: Text("Počet kusov na "
                                                //               "sklade:${snapshot.data![index].count_available}"),
                                                //         ),
                                                //
                                                //       ],
                                                //     ))
                                              ],
                                            ),
                                          )));
                                })])),

                      ])));
                    }
                    else {
                      if(allSetUp){
                        return Text("AA");
                      }else{
                        return Text("loading..");
                      }
                    }
                  }),
            ],
          ))
        ],
      ),
    ));
  }

  // showToastx(fullTitle) {
  //   return Toast.show(
  //       msg: fullTitle,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.blue,
  //       textColor: Colors.white);
  // }
}
