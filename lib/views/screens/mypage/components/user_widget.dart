import 'package:flutter/material.dart';
import 'package:palink_client/views/screens/mypage/components/profile_card.dart';
import 'package:palink_client/views/screens/mypage/mypage_screen.dart';
import 'package:palink_client/views/screens/mypage/components/user_info_card.dart';

import '../../../../models/user_model.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          children: [
            // ProfileCard(image: CircleAvatar(
            //   radius: 50,
            // //  backgroundImage: Image.network(user.userimage ?? '').image,
            // ),
            //   name: Text(
            //     user.username ?? '',
            //     style: const TextStyle(fontSize: 20),
            //   ),
            // ),
            // Divider(
            //   color: Colors.grey[80],
            //   thickness: 1.0,
            // ),
            // const SizedBox(
            //   width: 20,
            // ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InfoCard(section: '이름', name: user.username ?? ''),
                  const SizedBox(
                    height: 10,
                  ),
                  InfoCard(section: '번호', name:  user.phone_number ?? ''),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}