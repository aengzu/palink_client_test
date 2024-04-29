import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palink_client/contants/app_colors.dart';
import 'package:palink_client/views/screens/home/components/inner_card.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../contants/text_theme.dart';
class TodayCard extends StatefulWidget {
  const TodayCard({super.key});

  @override
  State<TodayCard> createState() => _TodayCardState();
}

class _TodayCardState extends State<TodayCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(5.0),
      width: 0.8 * screenWidth,
      decoration: BoxDecoration(
        color: Color(0xffF9F9F9),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 텍스트를 왼쪽으로 정렬하기 위해 추가
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0), // 왼쪽 여백 추가
            child: Text(
              '오늘의 대화 시나리오',
              style: textTheme().displayMedium,
              textAlign: TextAlign.left, // 텍스트를 왼쪽으로 정렬
            ),
          ),
          InnerCard(),
        ],
      ),
    );
  }
}
