import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_client/app_controller.dart';
import 'package:palink_client/views/screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AppController 초기화
    Get.put(AppController());

    return GetMaterialApp(
      title: 'Palink UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );


  }
}
