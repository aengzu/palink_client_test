import 'package:get/get.dart';
import 'package:palink_client/viewmodels/controllers/login_controller.dart';
import 'package:palink_client/viewmodels/controllers/user_profile_controller.dart';
import 'app_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppController());
    Get.put(LoginController());
    Get.put(UserProfileController());
  }
}
