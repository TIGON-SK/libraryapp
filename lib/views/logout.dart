import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'explore.dart';
import 'login.dart';

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