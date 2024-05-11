import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_client/contants/image_assets.dart';
import 'package:palink_client/viewmodels/controllers/category_controller.dart';
import 'package:palink_client/views/components/custom_button_lg.dart';
import 'package:palink_client/views/screens/home/components/bubble_special.dart';

import '../../components/custom_button_md.dart';
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.put(CategoryController());
    return Scaffold(
      appBar: AppBar(title: Text("카테고리 선택")),
      body: Column(
        children: [
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildeCharacter(),
            SizedBox(width: 5),
            BubbleSpecialTwo(
              text: '아래의 카테고리 중에서\n선택해줘',
              color: Color(0xffE4F0FE),
              isSender: false,
              tail: true,
              button: Obx(() => Wrap(
                direction: Axis.vertical,
                spacing: 11, // 버튼 사이의 수직 간격
                children: controller.categories.map((category) => CustomButtonMD(
                  label: category.categoryName,
                  onPressed: () => controller.goToChat(category),
                )).toList(),
              )),
            ),
          ],
        ),
      ],
      ),
    );
  }

  Padding _buildeCharacter() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 2, bottom: 0, top: 250),
      child: Image.asset(ImageAssets.character_img, width: 100, height: 230),  // Correct usage of the Image.asset method
    );
  }
}