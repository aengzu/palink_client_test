// 필요한 Flutter 머티리얼 패키지를 가져옵니다.
import 'package:flutter/material.dart';
// 사용자 정의 글꼴을 사용하기 위해 Google Fonts 패키지를 가져옵니다.
import 'package:google_fonts/google_fonts.dart';

// Google Fonts로 사용자 정의된 TextTheme을 정의하고 반환하는 함수입니다.
TextTheme textTheme() {
  return TextTheme(
    // DisplayLarge 텍스트 스타일.
    displayLarge: GoogleFonts.openSans(fontSize: 18.0, color: Colors.black),
    // 굵은 글꼴 무게가 있는 DisplayMedium 텍스트 스타일.
    displayMedium: GoogleFonts.openSans(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
    // BodyLarge 텍스트 스타일.
    bodyLarge: GoogleFonts.openSans(fontSize: 16.0, color: Colors.black),
    // BodyMedium 텍스트 스타일.
    bodyMedium: GoogleFonts.openSans(fontSize: 14.0, color: Colors.grey),
    // TitleMedium 텍스트 스타일.
    titleMedium: GoogleFonts.openSans(fontSize: 15.0, color: Colors.black),
  );
}