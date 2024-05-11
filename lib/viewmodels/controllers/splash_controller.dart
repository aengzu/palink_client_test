import 'package:get/get.dart';
import 'package:palink_client/app_controller.dart';
import 'package:palink_client/views/screens/auth/login_screen.dart';
import 'package:palink_client/views/screens/main_screens.dart';

class SplashController extends GetxController {
  // 앱 시작 시 필요한 데이터 로딩 등의 초기화 작업을 수행합니다.
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 3), _loadNextScreen);
  }

  void _loadNextScreen() {
    // 로그인 상태에 따라 다른 화면으로 이동
    if (Get.find<AppController>().isLoggedIn) {
      Get.offAll(() => MainScreens());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }
}
