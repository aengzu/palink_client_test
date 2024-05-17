import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:palink_client/models/user.dart';
import 'package:palink_client/viewmodels/controllers/login_controller.dart';
import 'package:palink_client/viewmodels/controllers/user_profile_controller.dart';
import 'package:palink_client/views/components/custom_button_lg.dart';

import 'components/user_info_card.dart';
class MyPageScreen extends StatelessWidget {
  final UserProfileController userProfileController = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();

    return Scaffold(
      appBar: AppBar(title: Text("My Page")),
      body: Obx(() {
        var user = userProfileController.user.value;
        if (user != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InfoCard(section: '이름', name: user.userName),
              InfoCard(section: '이메일', name: user.email),
              InfoCard(section: '성별', name: user.gender),
              InfoCard(section: '학교', name: user.school),

              SizedBox(height: 50,),

              CustomButtonLG(label: '편집하기', onPressed: () => _editUser(context, user))
            ],
          );
        } else {
          userProfileController.fetchUserInfo(loginController.token.value);
          return CircularProgressIndicator();
        }
      }),
    );
  }

  void _editUser(BuildContext context, User user) {
    // Implementation for editing user details
  }
}
