import 'package:get/get.dart';
import 'package:palink_client/services/auth_service.dart';
import 'package:palink_client/models/user.dart';

class UserProfileController extends GetxController {
  final AuthService _authService = AuthService();
  Rx<User?> user = Rx<User?>(null); // Rx to make it reactive

  Future<void> fetchUserInfo(String token) async {
    try {
      var userData = await _authService.getUserInfo(token);
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
