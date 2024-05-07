import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:palink_client/contants/app_url.dart';


class AuthService {
  get baseUrl => AppUrl.baseUrl;
  Future<String> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('${baseUrl}/auth/token'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      var decodedBody = utf8.decode(response.bodyBytes);
      return jsonDecode(decodedBody)['access_token'];
      // jsonDecode(response.body)['access_token'];
    } else {
      throw Exception('Failed to login with status code: ${response.statusCode}');
    }
  }


  Future<Map<String, dynamic>> getUserInfo(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/me'),
      headers: {'Authorization': 'Bearer $token'},  // 헤더에 토큰 포함 확인
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user info: Status code ${response.statusCode}');
    }
  }


}

