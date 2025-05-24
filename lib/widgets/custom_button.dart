import 'package:flutter/material.dart';
import 'package:magic_gemini_x_flutter/constants/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.functionName, required this.function});

  final String functionName;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        width: 400,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: kFourthColor),
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Center(child: Text(functionName, style: TextStyle(color: kSecondaryColor, fontSize: 16, fontWeight: FontWeight.bold),)
            ,),
      ),
    );
  }
}
