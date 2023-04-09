import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:libraryapp/api/getPopular.dart';

import '../api/book_data.dart';
import '../api/getBooksApi.dart';

class Home extends StatefulWidget {
  Map map = {};

  Home(this.map);

  @override
  State<Home> createState() => HomeState(map);
}

class HomeState extends State<Home> {
  Map dataWToken = {};

  HomeState(this.dataWToken);

  final List<Widget> list = [
    Image(
      image: AssetImage('assets/bookImages/bookimg1.jpg'),
      fit: BoxFit.fill,
    ),
    Image(
      image: AssetImage('assets/bookImages/bookimg2.jpg'),
      fit: BoxFit.fill,
    ),
    Image(
      image: AssetImage('assets/bookImages/bookimg3.jpg'),
      fit: BoxFit.fill,
    ),
    Image(
      image: AssetImage('assets/bookImages/bookimg4.jpg'),
      fit: BoxFit.fill,
    ),
    Image(
      image: AssetImage('assets/bookImages/bookimg5.jpg'),
      fit: BoxFit.fill,
    ),
    Image(
      image: AssetImage('assets/bookImages/bookimg6.jpg'),
      fit: BoxFit.fill,
    ),
    Image(
      image: AssetImage('assets/bookImages/bookimg7.jpg'),
      fit: BoxFit.fill,
    ),
    Image(
      image: AssetImage('assets/bookImages/bookimg8.jpg'),
      fit: BoxFit.fill,
    ),
  ];
  late List<Widget> a = [];

  @override
  void initState() {
    super.initState();
    setUpBooks();
  }

  void setUpBooks() async {
    BooksApi instance = BooksApi("");
    await instance.fetchBooks(dataWToken["obtainedToken"]);
    getPopular gp = new getPopular(instance.booksFetched);
    gp.pickBestBooks();
    List<Widget> newA = [];
    for (int i = 0; i < gp.topxbooks.length; i++) {
      newA.add(Container(
          padding: EdgeInsets.only(top: 50,left: 20,right: 20),
          child: Column(
            children: [
              Text(
                gp.topxbooks[i].title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text("${gp.topxbooks[i].reads_count} prečítaní",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 10),
              Image.network(
                "http://10.0.2.2:8000/books/${gp.topxbooks[i].image}",
                height: 250,
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
              )
            ],
          )));
    }
    setState(() {
      a = newA;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 50)),
        CarouselSlider(
            items: list.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(width: screenWidth, child: i);
                },
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 2.0,
            )),
        SizedBox(
          height: 50,
        ),
        Center(
            child: Text(
          "Najčítanejšie",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
        )),
        SizedBox(height: 20,),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(

            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 100,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          height: 500,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: a.length,
            itemBuilder: (BuildContext context, int index) {
              return a[index];
            },
          ),
        ),

      ],
    ));
  }
}
