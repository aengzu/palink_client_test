import 'package:flutter/material.dart';

class AppColors{
  static BoxDecoration buildGradientBoxDecoration(){


    return const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff6BB2FF), Color(0xff2A91FF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,

        )

    );

  }
}