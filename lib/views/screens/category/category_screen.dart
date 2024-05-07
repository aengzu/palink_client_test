
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_client/test.dart';

import '../../../contants/image_assets.dart';
import '../../components/appbar_perferred_size.dart';
import '../home/components/bubble_special.dart';
import '../home/components/roleplaying_btn.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("카테고리 선택")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        child: Center(
          child: Container(
            height: 300,
            child: Row(
              children: [
                _buildeCharacter(),
                Container(
                  color: Color(0xffe4f0fe),// Expanded를 사용하여 나머지 공간을 모두 차지하게 함
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Text('원하는 상황 카테고리를 골라줘!'),
                        RoleplayingButton(onPressed: (){Get.to(ChatPage());}),
                        SizedBox(height: 10),
                        RoleplayingButton(onPressed: (){Get.to(ChatPage());}),
                        SizedBox(height: 10),
                        RoleplayingButton(onPressed: (){Get.to(ChatPage());}),
                        SizedBox(height: 10),
                        RoleplayingButton(onPressed: (){Get.to(ChatPage());}),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildeCharacter() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Image.asset(ImageAssets.character_img, width: 100, height: 230),  // Correct usage of the Image.asset method
    );
  }

}
