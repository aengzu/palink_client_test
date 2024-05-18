import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:palink_client/models/category.dart';
import 'package:provider/provider.dart';
import 'componenets/custom_chat_input.dart';
import 'componenets/custom_chat_theme.dart';
import '../../../viewmodels/controllers/roleplaying_viewmodel.dart';

class RolePlayingScreen extends StatelessWidget {
  final Category category;
  final String conversationInfo;

  const RolePlayingScreen({Key? key, required this.category, required this.conversationInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RolePlayingViewModel(category, conversationInfo),
      child: Scaffold(
        appBar: AppBar(title: Text(category.categoryName)),
        body: Consumer<RolePlayingViewModel>(
          builder: (context, model, child) {
            if (model.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Container(
                  color: Colors.blue[100],
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "지금부터 롤플레잉이 시작됩니다.\n\n${model.scenarioMessage}",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Expanded(
                  child: Chat(
                    messages: model.messages,
                    onSendPressed: (message) => model.handleSendPressed(message.text),
                    showUserAvatars: true,
                    showUserNames: true,
                    user: model.user!,
                    customBottomWidget: CustomChatInput(
                      isVisible: true,
                      onSendPressed: (text) => model.handleSendPressed(text),
                    ),
                    theme: const CustomChatTheme(),
                  ),
                ),
                if (model.isDataLoading) CircularProgressIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }
}
