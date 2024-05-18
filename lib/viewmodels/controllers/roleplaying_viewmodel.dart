import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:palink_client/models/category.dart';
import 'package:palink_client/services/openai_service.dart';
import 'package:palink_client/viewmodels/controllers/user_profile_controller.dart';
import 'package:uuid/uuid.dart';

import '../../models/message.dart';

class RolePlayingViewModel extends ChangeNotifier {
  final UserProfileController userProfileController = Get.find<UserProfileController>();
  final OpenAIService openAIService = OpenAIService();
  final Category category;
  final String conversationInfo;
  List<types.Message> _messages = [];
  bool isLoading = true;
  bool isDataLoading = false;

  types.User? _user;
  final types.User _bot = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3bd');
  String scenarioMessage = '';

  List<types.Message> get messages => _messages;
  types.User? get user => _user;

  RolePlayingViewModel(this.category, this.conversationInfo) {
    _initializeUser();
    _initializeScenario();
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

  void _initializeScenario() async {
    scenarioMessage = await openAIService.generateNarrativeStory(conversationInfo);
    await _generateInitialAIPrompt();  // Generate the initial AI message
    isLoading = false;
    notifyListeners();
  }

  Future<void> _generateInitialAIPrompt() async {
    isDataLoading = true;
    notifyListeners();

    // Generate the first AI message based on the scenario
    String AIResponse = await openAIService.proceedRolePlaying(scenarioMessage, openAIService.messages);
    String botResponse;
    try {
      AIResponse = AIResponse.replaceAll("'", '"');
      Map<String, dynamic> responseJson = jsonDecode(AIResponse);
      botResponse = responseJson['답변'];
    } catch (e) {
      print(e);
      botResponse = AIResponse;
    }

    final botTextMessage = types.TextMessage(
      author: _bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: botResponse,
    );

    _addMessage(botTextMessage);

    // Append the AI message to OpenAIService messages list
    openAIService.messages.add(Message(role: 'assistant', content: botResponse));

    isDataLoading = false;
    notifyListeners();
  }

  void handleSendPressed(String text) async {
    if (_user == null) return;

    final textMessage = types.TextMessage(
      author: _user!,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: text,
    );

    _addMessage(textMessage);

    // Append user message to OpenAIService messages list
    openAIService.messages.add(Message(role: 'user', content: text));

    // Simulate a response from the bot after a delay
    isDataLoading = true;
    notifyListeners();

    String AIResponse = await openAIService.proceedRolePlaying(scenarioMessage, openAIService.messages);

    String botResponse;
    try {
      AIResponse = AIResponse.replaceAll("'", '"');
      Map<String, dynamic> responseJson = jsonDecode(AIResponse);
      botResponse = responseJson['답변'];
    } catch (e) {
      print(e);
      botResponse = AIResponse;
    }

    final botTextMessage = types.TextMessage(
      author: _bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: botResponse,
    );

    _addMessage(botTextMessage);

    // Append bot message to OpenAIService messages list
    openAIService.messages.add(Message(role: 'assistant', content: botResponse));

    isDataLoading = false;
    notifyListeners();
  }
}
