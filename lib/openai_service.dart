
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class OpenAIService {
  final List<Map<String, String>> messages = [];
  static const apiUri = 'https://api.openai.com/v1/chat/completions';
  static const apiKey = 'sk-proj-zXar2M8veKtnDWVsnjbzT3BlbkFJv6RKj9J1EECLwodDjjmv';

  Future<String> chatGPTAPI(String prompt) async {
    messages.add({
      "role": "user",
      "content": "You are a chatting bot called chatbot and you are supposed to only talk in Korean. Your role is given by user. This is the situation. $prompt",
    });

    try {
      final response = await http.post(
        Uri.parse(apiUri),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
          "temperature": 0.7
        }),
      );

      if (response.statusCode == 200) {
        String content = utf8.decode(response.bodyBytes);
        content = jsonDecode(content)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
      } else {
        return 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
