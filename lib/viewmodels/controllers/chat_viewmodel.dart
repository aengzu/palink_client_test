import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:palink_client/services/chat_service.dart';
import 'package:palink_client/services/openai_service.dart';
import 'package:palink_client/viewmodels/controllers/user_profile_controller.dart';
import 'package:uuid/uuid.dart';

import '../../models/category.dart';
import '../../views/screens/chatting/roleplaying_screen.dart';

class ChatViewModel extends ChangeNotifier {
  final UserProfileController userProfileController = Get.find<UserProfileController>();
  final OpenAIService openAIService = OpenAIService();
  final ChatService chatService = ChatService();
  List<types.Message> _messages = [];
  bool isDataLoading = false;
  final Category category;

  types.User? _user;
  final types.User _bot = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3bd');
  bool _showInputField = false;
  bool _showButtons = false;
  bool _awaitingDetailedScenario = false;

  List<types.Message> get messages => _messages;
  types.User? get user => _user;
  bool get showInputField => _showInputField;
  bool get showButtons => _showButtons;
  bool get awaitingDetailedScenario => _awaitingDetailedScenario;

  ChatViewModel({required this.category}) {
    _initializeUser();
    _loadInitialMessages();
  }

  void _initializeUser() {
    if (userProfileController.user.value != null) {
      var user = userProfileController.user.value!;
      _user = types.User(
        id: user.id.toString(),
        firstName: user.userName,
        lastName: '',
        imageUrl: '', // Add image URL if available
        metadata: {
          'email': user.email,
          'gender': user.gender,
          'school': user.school,
        },
      );
      notifyListeners();
    }
  }

  void _addMessage(types.Message message) {
    _messages.insert(0, message);
    notifyListeners();
  }

  String formatGuidelines(String guidelines) {
    List<String> items = guidelines.split(';');
    List<String> formattedItems = [];
    for (int i = 0; i < items.length; i++) {
      formattedItems.add('${i + 1}. ${items[i].trim()}');
    }
    return formattedItems.join('\n');
  }

  void _loadInitialMessages() async {
    try {
      String guidelines = await chatService.fetchCategoryGuidelines(category.categoryId);
      String formattedGuidelines = formatGuidelines(guidelines);

      _addMessage(types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: "좋은 아침 🌟",
      ));

      await Future.delayed(Duration(seconds: 2));
      _addMessage(types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: "[${category.categoryName}]에서 지켜야할 점을 알려줄게!",
      ));

      await Future.delayed(Duration(seconds: 2));
      _addMessage(types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: formattedGuidelines,
      ));

      await Future.delayed(Duration(seconds: 3));
      _addMessage(types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: "혹시 생각하고 있는 시나리오가 있니?",
      ));
      _showButtons = true;
      notifyListeners();
    } catch (e) {
      print('Error loading initial messages: $e');
    }
  }

  void enableInputField() {
    _showInputField = true;
    notifyListeners();
  }

  void hideButtons() {
    _showButtons = false;
    notifyListeners();
  }

  Future<void> handleSendPressed(String text, BuildContext context, Category category) async {
    if (_user == null) return;

    final textMessage = types.TextMessage(
      author: _user!,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: text,
    );

    _addMessage(textMessage);

    if (_awaitingDetailedScenario) {
      _awaitingDetailedScenario = false;

      Future.delayed(Duration(seconds: 1), () {
        final botResponse = types.TextMessage(
          author: _bot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: "알았어!",
        );
        _addMessage(botResponse);
      });

      final waitingResponse = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: "잠시만 기다려줘~",
      );
      _addMessage(waitingResponse);

      isDataLoading = true;
      notifyListeners();
      String conversationInfo = await openAIService.extractConversationInfo(text, category.categoryName, user!);
      isDataLoading = false;
      notifyListeners();

      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RolePlayingScreen(category: category, conversationInfo: conversationInfo),
          ),
        );
      });
    } else {
      Future.delayed(Duration(seconds: 1), () {
        final botResponse = types.TextMessage(
          author: _bot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: "나한테 그 상황을 자세히 알려줄래? 구체적인 상황과 그 친구와의 관계, 그리고 친구의 특성을 자세히 적어주면 좋을 것 같아",
        );
        _addMessage(botResponse);
      });

      _awaitingDetailedScenario = true;
      enableInputField();
    }
  }
}
