import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palink_client/models/category.dart';
import 'package:palink_client/views/components/appbar_perferred_size.dart';

class ChatScreen extends StatelessWidget {
  final Category category;

  const ChatScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('카테고리 화면'),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.bell)),
        ],
        bottom: appBarBottomLine(),
      ),
      body: Center(
        child: Text("${category.categoryName}에 대한 채팅 인터페이스입니다."),
      ),
    );
  }
}
