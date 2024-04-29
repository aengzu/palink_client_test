import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palink_client/contants/app_colors.dart';
import 'package:palink_client/contants/text_theme.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';


class InnerCard extends StatefulWidget {
  const InnerCard({Key? key}) : super(key: key);
  @override
  State<InnerCard> createState() => _InnerCardState();
}

class _InnerCardState extends State<InnerCard> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;


    return Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
      child: Card(
        color: Colors.white,
        elevation: 2.0,
        shape: RoundedRectangleBorder( // 사각형 모양으로 설정
          borderRadius: BorderRadius.circular(8.0), // 원하는 모서리 반지름 설정
        ),
        child: Container(
          padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
          child: Column(
            children: [
              Text(
                '갈등 해결하기', //category 데이터에서 불러오기해야함.
                style: textTheme().titleMedium,
                textAlign: TextAlign.left,
              ),
              Row(
                children: [
                  Expanded(child:_buildProgressbar()),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_circle_right, color: Color(0xff3E9BFF), size: 38.0),
                  ),
                ],

              )

            ],

          ),
        ),
      ),
    );
  }

  Padding _buildProgressbar(){
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: StepProgressIndicator(
      totalSteps: 5,
      currentStep: 2,
      size: 10,
      padding: 5,
      roundedEdges: Radius.circular(3.0),
      unselectedColor: Color(0xffD4D4D4),
      selectedColor: Color(0xff3E9BFF),
    ));
  }
}