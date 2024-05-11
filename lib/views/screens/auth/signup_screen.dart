import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_client/contants/text_theme.dart';
import 'package:palink_client/viewmodels/controllers/signup_controller.dart';
import 'package:palink_client/views/components/custom_button_lg.dart';
import 'package:palink_client/views/screens/mypage/mypage_screen.dart';


class SignUpScreen extends StatelessWidget {
  final SignUpController signUpController = Get.put(SignUpController());



  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("회원가입")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _buildTextField(
              controller: usernameController,
              labelText: '사용자 이름',
              hintText: '사용자 이름을 입력하세요.',
            ),
            SizedBox(height: 20),
            _buildTextField(
              controller: emailController,
              labelText: '이메일',
              hintText: '이메일을 입력하세요.',
            ),
            SizedBox(height: 20),
            _buildTextField(
              controller: passwordController,
              labelText: '비밀번호',
              hintText: '비밀번호를 입력하세요.',
              isObscure: true,
            ),
            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded( // 이 부분을 추가합니다.
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '성별',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 5),
                      Obx(() =>
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                              border: OutlineInputBorder(),
                            ),
                            value: signUpController.selectedGender.value,
                            items: <String>['남성', '여성'].map<
                                DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              signUpController.selectedGender.value = newValue!;
                            },
                          )),
                    ],
                  ),
                ),
                SizedBox(width: 30),
                Expanded( // 이 부을 추가합니다.
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '학교',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 5),
                      Obx(() =>
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                              border: OutlineInputBorder(),
                            ),
                            value: signUpController.selectedSchool.value,
                            items: <String>['중학교', '고등학교'].map<
                                DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              signUpController.selectedSchool.value = newValue!;
                            },
                          )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            CustomButtonLG(
              label: '회원가입하기',
              onPressed: () async {
                await signUpController.signUp(
                  usernameController.text,
                  emailController.text,
                  passwordController.text,
                  signUpController.selectedGender.value,
                  signUpController.selectedSchool.value,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    bool isObscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 라벨과 텍스트 필드를 왼쪽 정렬합니다.
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 16, // 적절한 폰트 사이즈로 조정
            fontWeight: FontWeight.bold, // 라벨에 볼드 스타일 적용
            color: Colors.black54, // 라벨 색상 조정
          ),
        ),
        SizedBox(height: 8), // 라벨과 텍스트 필드 사이의 간격 조정
        TextField(
          controller: controller,
          obscureText: isObscure,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 10.0),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}