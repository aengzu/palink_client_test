// Splash screen : 앱을 구동할 때 보이는 시작화면
// st 입력 후 엔터

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:palink_client/views/screens/login/login_screen.dart';

import '../../../contants/app_colors.dart';

import '../../../contants/image_assets.dart';
import '../../../services/splash_screen/splash_services.dart';
import '../main_screens.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SplashServices.getApiData();}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: AppColors.buildGradientBoxDecoration(),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width:30.0),
                Image.asset(ImageAssets.logo, height: 300, width: 200),
              ],
        ),),

        ),
        );

  }
}
