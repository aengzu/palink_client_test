import 'package:get/get.dart';

import 'package:palink_client/models/category.dart';
import 'package:palink_client/services/chat_service.dart';
import 'package:palink_client/views/screens/chatting/chat_screen.dart';

class CategoryController extends GetxController {
  var categories = <Category>[].obs;
  final ChatService chatService = ChatService();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() async {
    try {
      print('카테고리꺼냄');
      categories.value = await chatService.fetchCategories();
    } catch (e) {
      Get.snackbar('Error', '카테고리를 가져오는데 실패했습니다: $e');
    }
  }

  void goToChat(Category category) {
    Get.to(() => ChatScreen(category: category));
  }
}
