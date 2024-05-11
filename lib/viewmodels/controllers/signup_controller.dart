import 'package:get/get.dart';
import 'package:palink_client/services/auth_service.dart';
import 'package:palink_client/views/screens/main_screens.dart';

class SignUpController extends GetxController {
  final AuthService _authService = AuthService();
  RxString token = ''.obs;
  var selectedGender = '남성'.obs;  // 기본 성별 선택값
  var selectedSchool = '중학교'.obs;

  Future<void> signUp(String username, String email, String password, String gender, String school) async {
    try {
      token.value = await _authService.register(username, email, password, gender, school);
      if (token.isNotEmpty) {
        Get.offAll(() => MainScreens());  // 회원가입 후 메인 페이지로 리다이렉션
      }
    } catch (e) {
      Get.snackbar("Sign Up Failed", e.toString());
    }
  }
}
