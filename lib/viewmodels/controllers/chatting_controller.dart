// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:http/http.dart' as http;
// import 'package:uuid/uuid.dart';
//
// class ChatViewModel with ChangeNotifier {
//   List<types.Message> _messages = [];
//   final types.User _user = const types.User(id: 'user-id');
//
//   List<types.Message> get messages => _messages;
//   types.User get user => _user;
//
//   void sendMessage(String text) async {
//     final messageId = const Uuid().v4();
//     final textMessage = types.TextMessage(
//       author: _user,
//       createdAt: DateTime.now().millisecondsSinceEpoch,
//       id: messageId,
//       text: text,
//     );
//
//     _messages.insert(0, textMessage);
//     notifyListeners();
//
//     final response = await sendToOpenAI(text);
//     addBotMessage(response);
//   }
//
//   Future<String> sendToOpenAI(String text) async {
//   //  const  = ;
//     final url = Uri.parse('https://api.openai.com/v1/engines/davinci-codex/completions');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearegitr $apiKey'
//       },
//       body: jsonEncode({
//         'prompt': text,
//         'max_tokens': 150,
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data['choices'][0]['text'];
//     } else {
//       return 'Error: Failed to fetch response from OpenAI';
//     }
//   }
//
//   void addBotMessage(String text) {
//     final message = types.TextMessage(
//       author: const types.User(id: 'bot-id'),
//       createdAt: DateTime.now().millisecondsSinceEpoch,
//       id: const Uuid().v4(),
//       text: text.trim(),
//     );
//
//     _messages.insert(0, message);
//     notifyListeners();
//   }
// }
