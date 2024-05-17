import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:palink_client/contants/app_url.dart';
import 'package:palink_client/models/category.dart';

class ChatService {

  get baseUrl => AppUrl.baseUrl;

  Future<List<Category>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/categories'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List;
        return jsonData.map((data) => Category.fromJson(data)).toList();
      } else {
        throw Exception('Failed to fetch categories');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  // 채팅 세션 시작
  // 채팅 세션 시작 메소드 수정
  Future<int> initiateChatSession(int categoryId) async {
    try {
      final response = await http.post(
          Uri.parse('$baseUrl/chats/start'),
          headers: {"Content-Type": "application/json"},
          body: json.encode({"category_id": categoryId})
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data['session_id']; // 세션 ID 반환 가정
      } else {
        throw Exception('Failed to initiate chat session with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error initiating chat session: $e');
    }
  }


  // 메시지 보내기
  Future<void> sendMessage(int sessionId, String message) async {
    try {
      final response = await http.post(
          Uri.parse('$baseUrl/chat/$sessionId/send'),
          headers: {"Content-Type": "application/json"},
          body: json.encode({"message": message})
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to send message with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error sending message: $e');
    }
  }

  // 채팅 기록 받기
  Future<List<Map<String, dynamic>>> fetchChatHistory(int sessionId) async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/chat/$sessionId/history'),
          headers: {"Content-Type": "application/json"}
      );
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      } else {
        throw Exception('Failed to fetch chat history with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching chat history: $e');
    }
  }

  // 채팅 세션 종료
  Future<void> endChatSession(int sessionId) async {
    try {
      final response = await http.post(
          Uri.parse('$baseUrl/chat/$sessionId/end'),
          headers: {"Content-Type": "application/json"}
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to end chat session with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error ending chat session: $e');
    }
  }
}
