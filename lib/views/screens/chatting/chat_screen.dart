import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/controllers/chat_viewmodel.dart';
import 'componenets/custom_chat_input.dart';
import 'componenets/custom_chat_theme.dart';
import 'componenets/custom_btn_small.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatViewModel(),
      child: Scaffold(
        appBar: AppBar(title: Text("대화창")),
        body: Consumer<ChatViewModel>(
          builder: (context, model, child) {
            if (model.user == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Expanded(
                  child: Chat(
                    messages: model.messages,
                    onSendPressed: model.showInputField
                        ? (message) => model.handleSendPressed(message.text)
                        : (message) {}, // Provide a no-op function when input field is hidden
                    showUserAvatars: true,
                    showUserNames: true,
                    user: model.user!,
                    customBottomWidget: CustomChatInput(
                      isVisible: model.showInputField,
                      onSendPressed: (text) => model.handleSendPressed(text),
                    ),
                    theme: const CustomChatTheme(), // Apply custom theme
                  ),
                ),
                if (model.isDataLoading) CircularProgressIndicator(),
                Visibility(
                  visible: model.showButtons, // Show buttons based on state
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: Offset(0, 2), // changes position of shadow
                        ),
                        ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButtonSM(
                            text: "응, 있어",
                            onPressed: () {
                              model.handleSendPressed("응, 있어");
                              model.enableInputField();
                              model.hideButtons();
                            },
                          ),
                          CustomButtonSM(
                            text: "아니, 없어",
                            onPressed: () {
                              model.handleSendPressed("아니, 없어");
                              model.hideButtons();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
