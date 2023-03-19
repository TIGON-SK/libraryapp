import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_){
    Navigator.of(context).popUntil(ModalRoute.withName('/login'));
    });
    return Scaffold(
      body: Container(
        child: Text("Logging out..."),
      ),
    );
}
}