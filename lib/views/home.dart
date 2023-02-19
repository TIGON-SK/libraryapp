import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home(Map map, {Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
  final List<Widget> a = [
    Container(padding: EdgeInsets.only(top:50),child:Image.network("http://10.0.2.2:8000/books/10000000.webp",width: 170,),),
    Container(padding: EdgeInsets.only(top:50),child:Image.network("http://10.0.2.2:8000/books/10000000.webp",width: 170,),),
    Container(padding: EdgeInsets.only(top:50),child:Image.network("http://10.0.2.2:8000/books/10000000.webp",width: 170,),),
  ];

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

    Column(
    children:
    a
    )
     ],
    ));
  }
}
