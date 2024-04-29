import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class RoleplayingButton extends StatelessWidget {
  final VoidCallback onPressed;
  const RoleplayingButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0, // 버튼의 높이 설정
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // 버튼의 모서리를 둥글게 처리
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xff3dadff), Color(0xff1986fc)], // 그라디언트 색상 설정
          )
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, // 배경색을 투명하게 설정
            shadowColor: Colors.transparent, // 그림자 색상을 투명하게 설정
          ),
          onPressed: onPressed, // 버튼 클릭 이벤트 연결
          child: Text(
            "롤플레잉 하러가기",
            style: const TextStyle(
              color: Colors.white, // 글자색을 흰색으로 설정
              fontSize: 15, // 글자 크기를 20으로 설정
            ),
          )
      ),
    );
  }
}
