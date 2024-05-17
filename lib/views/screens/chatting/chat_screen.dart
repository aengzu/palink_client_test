import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:palink_client/models/category.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/controllers/chat_viewmodel.dart';
import 'componenets/custom_chat_input.dart';
import 'componenets/custom_chat_theme.dart';
import 'componenets/custom_btn_small.dart';

class ChatScreen extends StatelessWidget {
  final Category category;

  const ChatScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatViewModel(),
      child: Scaffold(
        appBar: AppBar(title: Text(category.categoryName)),
        body: Consumer<ChatViewModel>(
          builder: (context, model, child) {
            if (model.user == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: model.showInputField ? 25.0 : 8.0),
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
                ),
                if (model.isDataLoading) CircularProgressIndicator(),
                if (!model.showInputField)
                  Container(
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
                      padding: const EdgeInsets.only(top: 15.0, bottom: 30.0, left: 0.0, right: 0.0),
                      child: SizedBox(
                        height: 70.0, // Make the height consistent whether buttons are visible or not
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Visibility(
                              visible: model.showButtons,
                              child: CustomButtonSM(
                                text: "응, 있어",
                                onPressed: () {
                                  model.handleSendPressed("응, 있어");
                                  model.enableInputField();
                                  model.hideButtons();
                                },
                              ),
                            ),
                            Visibility(
                              visible: model.showButtons,
                              child: CustomButtonSM(
                                text: "아니, 없어",
                                onPressed: () {
                                  model.handleSendPressed("아니, 없어");
                                  model.hideButtons();
                                },
                              ),
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
