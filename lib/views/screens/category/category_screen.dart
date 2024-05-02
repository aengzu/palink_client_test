import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text('카테고리 화면'),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.bell)),
        ],
        bottom: appBarBottomLine(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
              children: [
                _buildeCharacter(),
                BubbleSpecialTwo(text: '안녕 👋🏻나는 AI 챗봇이야.\n나랑 롤플레잉 하러 가자',color: Color(0xffE4F0FE),
                  isSender:false,tail: true,button: RoleplayingButton(onPressed: (){},),
            ),
          ],
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
