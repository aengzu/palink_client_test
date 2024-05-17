import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:palink_client/contants/image_assets.dart';
import 'package:palink_client/models/user.dart';
import 'package:palink_client/viewmodels/controllers/user_profile_controller.dart';
import 'package:uuid/uuid.dart';

class ChatViewModel extends ChangeNotifier {
  final UserProfileController userProfileController = Get.find<UserProfileController>();
  List<types.Message> _messages = [];

  types.User? _user;
  final types.User _bot = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3bd');
  bool isDataLoading = false;
  bool _showInputField = false;
  bool _showButtons = false;

  List<types.Message> get messages => _messages;
  types.User? get user => _user;
  types.User get bot => _bot;
  bool get showInputField => _showInputField;
  bool get showButtons => _showButtons;

  ChatViewModel() {
    _initializeUser();
    _loadInitialMessages();
  }

  void _addMessage(types.Message message) {
    _messages.insert(0, message);
    notifyListeners();
  }

  void _loadInitialMessages() {
    Future.delayed(Duration(seconds: 1), () {
      _addMessage(types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: "좋은 아침 🌟",
      ));
    });

    Future.delayed(Duration(seconds: 2), () {
      _addMessage(types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: "[거절 연습 시나리오]에서 지켜야할 점을 알려줄게!",
      ));
    });

    Future.delayed(Duration(seconds: 4), () {
      _addMessage(types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: "1. 거절할 때 상대방의 감정을 고려하면서도 자신의 의사를 확실히 전달하기",
      ));
    });

    // Add the new delayed message for user interaction
    Future.delayed(Duration(seconds: 7), () {
      _addMessage(types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: "혹시 생각하고 있는 시나리오가 있니?",
      ));
    });

    // Add user's automatic response
    Future.delayed(Duration(seconds: 9), () {
      if (_user != null) {
        _addMessage(types.TextMessage(
          author: _user!,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: "안녕 👋",
        ));
      }

      // Show buttons after 1 second delay from "안녕 👋" message
      Future.delayed(Duration(seconds: 1), () {
        _showButtons = true;
        notifyListeners();
      });
    });
  }

  void _initializeUser() {
    print("Initializing user...");
    if (userProfileController.user.value != null) {
      print("User is already initialized.");
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

    userProfileController.user.listen((user) {
      if (user != null) {
        print("User data changed: ${user.userName}");
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
      } else {
        print("User data is null");
      }
    });
  }

  void enableInputField() {
    _showInputField = true;
    notifyListeners();
  }

  void hideButtons() {
    _showButtons = false;
    notifyListeners();
  }

  Future<void> handleSendPressed(String text) async {
    if (_user == null) return;

    final textMessage = types.TextMessage(
      author: _user!,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: text,
    );

    _addMessage(textMessage);

    // Simulate a response from the bot after a delay
    await Future.delayed(Duration(seconds: 1));
    final botResponse = types.TextMessage(
      author: _bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: "안녕 👋",
    );

    _addMessage(botResponse);
  }
}
