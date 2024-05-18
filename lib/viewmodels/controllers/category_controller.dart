import 'package:get/get.dart';
import 'package:palink_client/models/category.dart';
import 'package:palink_client/services/chat_service.dart';
import 'package:palink_client/views/screens/chatting/chat_screen.dart';
import 'package:palink_client/viewmodels/controllers/user_profile_controller.dart';

import 'login_controller.dart';

class CategoryController extends GetxController {
  var categories = <Category>[].obs;
  final ChatService chatService = ChatService();
  var selectedCategoryId;

  final UserProfileController userProfileController = Get.find<UserProfileController>();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() async {
    categories.value = await chatService.fetchCategories();
  }

  void goToChat(Category category) async {
    selectedCategoryId = category.categoryId; // 선택된 카테고리 ID 설정
    print(category.categoryName);

    // Ensure user data is initialized before navigating
    if (userProfileController.user.value == null) {
      await userProfileController.fetchUserInfo(Get.find<LoginController>().token.value!);
    }
    Get.to(() => ChatScreen(category: category)); // Pass the category to ChatScreen
  }
}
