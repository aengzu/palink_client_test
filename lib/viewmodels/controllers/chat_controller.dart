import 'package:get/get.dart';
import 'package:palink_client/services/chat_service.dart';
import 'package:flutter/material.dart';

class ChatController extends GetxController {
  final ChatService apiService = ChatService();
  RxList<String> messages = RxList<String>();
  TextEditingController textController = TextEditingController();
  var selectedCategoryId = 0.obs; // 이 값을 설정하는 로직 추가 필요

  // 메시지 전송 로직 수정
  void sendScenario(String text) async {
    try {
      int sessionId = await apiService.initiateChatSession(selectedCategoryId.value);
      await apiService.sendMessage(sessionId, text);
      messages.add("Scenario started: $text"); // 예제 메시지 추가
      update();
    } catch (e) {
      Get.snackbar("Error", "Failed to start chat scenario: $e");
    }
  }

}
