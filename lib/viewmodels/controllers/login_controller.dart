import 'package:get/get.dart';
import 'package:palink_client/services/auth_service.dart';


class LoginController extends GetxController {
  final AuthService _authService = AuthService();
  RxString token = ''.obs;

  Future<void> login(String username, String password) async {
    try {
      token.value = await _authService.login(username, password);
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    }
  }
}
