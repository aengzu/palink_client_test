
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:palink_client/contants/image_assets.dart';
import 'package:palink_client/views/components/appbar_perferred_size.dart';
import 'package:palink_client/views/components/custom_appbar.dart';
import 'package:palink_client/views/screens/home/components/roleplaying_btn.dart';

import '../../components/custom_button_lg.dart';
import 'components/bubble.dart';
import 'components/bubble_special.dart';
import 'components/today_scenario_card.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('mypage 화면'),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.bell)),
        ],
        bottom: appBarBottomLine(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          TodayCard(),
          SizedBox(height: 80,),
          Row(
            children: [
              _buildeCharacter(),
              BubbleSpecialTwo(text: '안녕 👋🏻나는 AI 챗봇이야.\n나랑 롤플레잉 하러 가자',color: Color(0xffE4F0FE),
              isSender:false,tail: true,button: RoleplayingButton(onPressed: (){},),
              ),
            ],
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
