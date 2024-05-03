import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserScreen(),
    );
  }
}

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  // usreData 에 json 형식으로 담기게 된다.
  Map<String, dynamic> userData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/users/1234'));
      if (response.statusCode == 200) {
        // UTF-8로 디코드를 명시적으로 처리
        final body = utf8.decode(response.bodyBytes);
        setState(() {
          userData = json.decode(body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userData.isEmpty
          ? Center(child: Text('No data found'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // json 에서 key 값으로 접근할 수 있다.
            Text('ID: ${userData['id']}'),
            Text('Username: ${userData['username']}'),
            Text('Email: ${userData['email']}'),
            Text('Phone Number: ${userData['phone_number']}'),
            Text('Gender: ${userData['gender']}'),
            Text('School: ${userData['school']}'),
          ],
        ),
      ),
    );
  }
}
