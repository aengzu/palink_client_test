import 'package:get/get.dart';

import '../../viewmodels/controllers/home_controller.dart';


class SplashServices {
  static void getApiData() {
    final controller = Get.put(HomeController());
    controller.getData();
    //HomeController 인스턴스를 생성하고, getData 메소드를 호출하여 API 데이터를 가져옴
  }
}
