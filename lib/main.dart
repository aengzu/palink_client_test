import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:palink_client/contants/image_assets.dart';
import 'package:palink_client/views/screens/main_screens.dart';
import 'package:palink_client/views/screens/splash/splash_screen.dart';

void main() => runApp(const PalinkUI());


class PalinkUI extends StatelessWidget {
  const PalinkUI({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'palink_ui',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}




