import 'package:get/get.dart';
import 'package:palink_client/models/category.dart';
import 'package:palink_client/services/chat_service.dart';
import 'package:palink_client/views/screens/chatting/chat_screen.dart';

class CategoryController extends GetxController {
  var categories = <Category>[].obs;
  final ChatService chatService = ChatService();
  var selectedCategoryId;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() async {
    categories.value = await chatService.fetchCategories();
  }

  void goToChat(Category category) {
    selectedCategoryId.value = category.categoryId; // 선택된 카테고리 ID 설정
    Get.to(() => ChatScreen());
  }

}
