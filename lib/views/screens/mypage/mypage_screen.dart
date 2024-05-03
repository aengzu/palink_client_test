import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_client/views/screens/mypage/components/user_widget.dart';


import '../../../viewmodels/controllers/user_controller.dart';

class MyPageScreen extends StatelessWidget {
  MyPageScreen({super.key});
  final userListController = Get.put(UserController());

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        title: Text('mypage 화면')),
          body: Column(
            children: [
              const TabBar(
                  indicatorColor: Colors.blue,
                  labelStyle: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.normal,
                      fontSize: 18),
                  indicatorWeight: 3,
                  tabs: [
                    Tab(
                      text: '내정보',
                      height: 50,
                    ),
                    Tab(
                      text: '대화 기록',
                      height: 50,
                    ),
                  ]),
              Expanded(
                  child: TabBarView(children: [
                  GetX<UserController>(builder: (_) {
              if (userListController.loading == true) {
              return loading();
              } else {
              return UserWidget(
              user: userListController.userDataList[0],
              );
              }
              }),
                    ListView.builder(
                        key: const PageStorageKey("LIST_VIEW"),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                "List View $index",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.accents[index % 15],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }),
                  ]))
            ],
          ),
      ),
    );
  }
}