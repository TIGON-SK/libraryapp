import 'dart:convert';
import 'package:http/http.dart' as http;

import 'bookUser_data.dart';



class BookUsersApi {
  BookUsersApi();

  List<BookUser> bookUsersFetched = [];
  Map<String, dynamic> map = {};

  Future<void> fetchBookUsers(token) async {
    final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/reserve/getBookUsers'),
        headers: {
          "Accept": "application/json",
          'Authorization': "Bearer " + token
        });
    BookUsers bookUsersx = BookUsers.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      bookUsersFetched = bookUsersx.bookUsers;
    } else {
      throw Exception('Failed to load book users');
    }
  }
}
