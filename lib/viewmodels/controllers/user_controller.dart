import 'package:get/get.dart';

import '../../models/user_model.dart';
import '../../repository/user_repository.dart';


class UserController extends GetxController {
  late UserRepository userRepository;
  RxList<UserModel> userDataList = <UserModel>[].obs;
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    userRepository = UserRepository();
  }

  void loadUser() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    final userList = await userRepository.getUserInfo();
    userDataList.value = userList;
    loading = false;
  }
}