import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:libraryapp/api/userToken_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<UserWithToken> fetchUserToken(String email,String password) async {

  final response = await http
      .post(Uri.parse('http://10.0.2.2:8000/api/user'),
      body:{
        "email":email,
        "password":password,
      }
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token',UserWithToken.fromJson(jsonDecode(response.body)).token );
    return UserWithToken.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}