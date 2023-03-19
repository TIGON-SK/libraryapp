import 'package:flutter/material.dart';
import 'package:libraryapp/views/login.dart';


void main() => runApp(MaterialApp(initialRoute: '/login', routes: {
      '/login': (context) => Login(),
    }
    )
);