import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user_model.dart';


class UserRepository {
  Future<List<UserModel>> getUserInfo() async {
    try {
      final userInfo =
      await http.get(Uri.parse('https://randomuser.me/api/?results=30'));
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