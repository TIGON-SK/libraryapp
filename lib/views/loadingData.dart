import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setUpBooks() async {
  }

  @override
  void initState() {
    super.initState();
    setUpBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();// widget tree
  }
}