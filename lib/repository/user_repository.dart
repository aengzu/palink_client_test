import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user_model.dart';


class UserRepository {
  Future<List<UserModel>> getUserInfo() async {
    try {
      final userInfo =
      await http.get(Uri.parse('http://127.0.0.1:8000/users/1234'));
      if (userInfo.statusCode == 200) {
        var userInfoData = jsonDecode(userInfo.body);
        List<UserModel> userList = userInfoData['results']
            .map<UserModel>((data) => UserModel.fromJson(data))
            .toList();
        return userList;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}