
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magic_gemini_x_flutter/constants/colors.dart';

class CustomLoadingButtton extends StatelessWidget {
  const CustomLoadingButtton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: kFourthColor),
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Center(child: CupertinoActivityIndicator(color: kSecondaryColor,),)
            ,);
      
  }
}