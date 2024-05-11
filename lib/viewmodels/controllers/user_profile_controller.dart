import 'package:get/get.dart';
import 'package:palink_client/services/auth_service.dart';
import 'package:palink_client/models/user.dart';

import 'login_controller.dart';

class UserProfileController extends GetxController {
  final AuthService _authService = AuthService();
  Rx<User?> user = Rx<User?>(null); // Rx to make it reactive

  @override
  void onInit() {
    super.onInit();
    // 토큰이 있다면 사용자 정보를 불러옵니다.
    String? token = Get.find<LoginController>().token.value;
    if (token != null) {
      fetchUserInfo(token);
    }
  }

  Future<void> fetchUserInfo(String token) async {
    try {
      var userData = await _authService.getUserInfo(token);
      print(userData);
      user.value = User.fromJson(userData); // Convert JSON to a User object
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch user info: $e");
      user.value = null;
    }
  }

  void updateUser(User updatedUser) {
    user.value = updatedUser; // Directly update the User object
    // You might want to update the user information in the backend as well
  }

  User? get userInfo => user.value; // Expose user information safely
}
