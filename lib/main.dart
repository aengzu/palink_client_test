import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_client/app_controller.dart';
import 'package:palink_client/initial_binding.dart';
import 'package:palink_client/viewmodels/controllers/login_controller.dart';
import 'package:palink_client/viewmodels/controllers/user_profile_controller.dart';
import 'package:palink_client/views/screens/splash/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Palink UI',
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );


  }
}
