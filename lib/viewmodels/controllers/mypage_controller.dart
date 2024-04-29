
import 'dart:async';

import 'package:get/get.dart';
import 'package:palink_client/views/screens/home/components/today_scenario_card.dart';
import 'package:palink_client/views/screens/main_screens.dart';

import '../../models/today_scenario.dart';
import '../../models/user.dart';
import '../../repository/home_repository.dart';
import '../../views/screens/home/home_screen.dart';


// GetXController 를 상속받아 상태 관리를 수행한다.
class MyPageController extends GetxController {

  Rx<User?> model = Rx<User?>(null);



  // TODO get 함수 정의하기


  getData() {
    Get.testMode = true;
    HomeRepositry.hitApi().then((value) {
      //.then((value) {: hitApi 메소드가 완료되면, 결과값 value를 사용하여 이어지는 블록({})의 코드를 실행
      // then 메소드는 Future 객체의 완료를 처리
      print(value);

    }
    );


    // navigate user to homescreen

  }

}
