import 'package:flutter/material.dart';
import 'package:libraryapp/views/profile.dart';

import 'explore.dart';
import 'home.dart';
import 'info.dart';
import 'login.dart';
import 'logout.dart';

class Welcome extends StatefulWidget {
  Map map = {};
  Welcome(this.map);

  @override
  WelcomeState createState() => WelcomeState(map);
}

class WelcomeState extends State<Welcome> {
  Map map = {};
  WelcomeState(this.map);
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  //Future<List> bookList;
  bool loading = true;
  bool filledParams=false;
  @override
  Widget build(BuildContext context) {
    final List _widgetOptions = [
      //Settings(map),
      Home(map),
      Explore(map, loading, filledParams),
      Profile(map),
      Info(map),
      Logout(),
    ];
    return Scaffold(
      body:
        Container(
          child:
          _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings,color: Colors.blueGrey),
          //   label: 'Settings',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.travel_explore,color: Colors.black),
            label: 'Hľadať',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,color: Colors.black),
            label: 'Profil',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.info,color: Colors.black),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout,color: Colors.black),
            label: 'Log out',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey,
        onTap: _onItemTapped,
      ),
    );
  }
}