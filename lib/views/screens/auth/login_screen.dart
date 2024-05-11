import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_client/contants/text_theme.dart';
import 'package:palink_client/viewmodels/controllers/login_controller.dart';
import 'package:palink_client/views/components/custom_button_lg.dart';
import 'package:palink_client/views/screens/auth/signup_screen.dart';
import 'package:palink_client/views/screens/main_screens.dart';
import 'package:palink_client/views/screens/mypage/mypage_screen.dart';

class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("로그인")),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // 추가한 전체 Padding
        child: Column(
          children: [
            SizedBox(height: 50,),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: '이름을 입력하세요.',
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0), // 추가한 필드별 Padding
                border: OutlineInputBorder( // 추가한 테두리 스타일
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'password를 입력하세요.',
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0), // 추가한 필드별 Padding
                border: OutlineInputBorder( // 추가한 테두리 스타일
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 40), // 버튼과의 간격
            CustomButtonLG(label: '로그인하기', onPressed: () async {
              await loginController.login(emailController.text, passwordController.text);
              if (loginController.token.isNotEmpty) {
                Get.to(() => MainScreens());
              }
            },
            ),
            TextButton(
              onPressed: () {Get.to(()=>SignUpScreen());},
              child: const Text(
                '회원 가입하기',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
