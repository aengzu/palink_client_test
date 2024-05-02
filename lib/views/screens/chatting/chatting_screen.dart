import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/controllers/chatting_controller.dart';


class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatViewModel(),
      child: Consumer<ChatViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          appBar: AppBar(title: Text("Chatbot")),
          body: Chat(
            messages: viewModel.messages,
            onSendPressed: (partialText) {
              viewModel.sendMessage(partialText.text);
            },
            user: viewModel.user,
          ),
        ),
      ),
    );
  }
}
