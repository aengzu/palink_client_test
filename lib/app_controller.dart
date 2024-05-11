import 'package:get/get.dart';
import 'package:palink_client/services/auth_service.dart';
import 'package:palink_client/services/auth_service.dart';

class AppController extends GetxController{
  final AuthService _authService = AuthService();
  final RxBool _isLoggedIn = false.obs;

  @override
  void onInit() {
    _isLoggedIn.value = _authService.isLoggedIn();
    super.onInit();
  }
  bool get isLoggedIn => _isLoggedIn.value;
}