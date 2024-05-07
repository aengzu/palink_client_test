import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class OpenAIService {
  final List<Map<String, String>> messages = [];
  static const apiUri = 'https://api.openai.com/v1/chat/completions';

  // TODO: 여기에 키
  get apiKey =>

  Future<String> chatGPTAPI(String prompt) async {
    // 유저의 메시지를 메시지 리스트에 추가
    messages.add({
      "role": "user",
      "content": "You are a roleplaying chatting bot called chatbot and you are supposed to only talk in Korean. You are korean teenager. Your personality is very bad . Your role is given by user. This is the situation. $prompt",
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
        Map decodedContent = jsonDecode(content);
        String replyMessage = decodedContent['choices'][0]['message']['content'];
        replyMessage = replyMessage.trim();

        // GPT의 응답 메시지를 메시지 리스트에 추가
        messages.add({
          'role': 'assistant',
          'content': replyMessage,
        });

        return replyMessage;
      } else {
        return 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
