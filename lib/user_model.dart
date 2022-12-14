// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  late int id;
  late String name;
  late String avatar;

  User({required this.id, required this.name, required this.avatar});

  factory User.createUser(Map<String, dynamic> object) {
    return User(
      id: object['id'],
      name: "${object['first_name']} ${object['last_name']}",
      avatar: object['avatar'],
    );
  }

  static Future<User> getFromAPI(String id) async {
    String apiURL = "https://reqres.in/api/users/$id";

    var apiResult = await http.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(apiResult.body);

    var userData = (jsonObject as Map<String, dynamic>)['data'];

    return User.createUser(userData);
  }
}
