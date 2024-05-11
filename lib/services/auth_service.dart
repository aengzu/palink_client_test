import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:palink_client/contants/app_url.dart';

class AuthService {
  String? _token;

  get baseUrl => AppUrl.baseUrl;

  Future<String> login(String username, String password) async {
    final response = await http.post(
        Uri.parse('${baseUrl}/auth/token'),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {
          'username': Uri.encodeComponent(username),
          'password': Uri.encodeComponent(password)
        }
    );

    if (response.statusCode == 200) {
      var decodedBody = utf8.decode(response.bodyBytes);
      _token = jsonDecode(decodedBody)['access_token'];
      return _token!;
    } else {
      throw Exception('Failed to login with status code: ${response.statusCode}');
    }
  }

  Future<String> register(String username, String email, String password, String gender, String school) async {
    final response = await http.post(
        Uri.parse('$baseUrl/auth/'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "username": username,
          "email": email,
          "gender": gender,
          "school": school,
          "password": password
        })
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body)['access_token'];
    } else {
      throw Exception('Failed to register with status code: ${response.statusCode}, body: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getUserInfo(String token) async {
    final response = await http.get(
        Uri.parse('$baseUrl/users/me'),
        headers: {'Authorization': 'Bearer $token'}
    );

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to fetch user info: Status code ${response.statusCode}, body: ${response.body}');
    }
  }

  bool isLoggedIn() => _token != null;
}
