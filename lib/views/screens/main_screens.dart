
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palink_client/viewmodels/controllers/mypage_controller.dart';

import '../../test.dart';
import 'chatting/chatting_screen.dart';
import 'home/home_screen.dart';
import 'mypage/mypage_screen.dart';



class MainScreens extends StatefulWidget {
  const MainScreens({super.key});

  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(),
          ChatPage(),
          MyPageScreen(),
        ],

      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(label: '홈', icon: Icon(CupertinoIcons.home)),
          BottomNavigationBarItem(label: '채팅', icon: Icon(CupertinoIcons.chat_bubble)),
          BottomNavigationBarItem(label: '내 정보', icon: Icon(CupertinoIcons.person_crop_circle_fill))
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
