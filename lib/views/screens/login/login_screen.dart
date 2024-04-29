import 'package:flutter/material.dart';

import '../../../contants/image_assets.dart';
import '../../components/custom_button_lg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( // Center 위젯으로 전체 내용을 화면 중앙에 위치시킵니다.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 세로축 기준 중앙
          crossAxisAlignment: CrossAxisAlignment.center, // 가로축 기준 중앙
          children: [
            Image.asset(ImageAssets.logo_link, height: 250, width: 400), // 로고 이미지를 추가합니다.
            const SizedBox(height: 10), // 로고와 버튼 사이의 간격을 줍니다.
            CustomButtonLG(label: '카카오톡으로 시작하기', onPressed: (){}),
            const SizedBox(height: 10),
            CustomButtonLG(label: '이메일로 로그인', onPressed: (){}),
          ],),),
    );
  }
}

