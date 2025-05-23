// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:magic_gemini_x_flutter/constants/colors.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    super.key,
    required this.textController,

    required this.hintText,
    this.isObscure,
    this.suffixIcon
  });

  final TextEditingController textController;

  final String hintText;
  final bool? isObscure;
  final IconButton? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      // 
      width: 400,
      height: 50,
      decoration: BoxDecoration(
          color: kThirdColor, borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          TextField(
            obscureText: isObscure ?? false,
            controller: textController,
            maxLines: 1,
            minLines: 1,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
               suffixIcon: suffixIcon,
              hintText: hintText,
              hintStyle: TextStyle(color: kFifthColor),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }
}
