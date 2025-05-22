// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:magic_gemini_x_flutter/constants/colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.textController,
    required this.function,
  });

  final TextEditingController textController;
  final Function function;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _keyboardFocusNode = FocusNode();
  final FocusNode _textFieldFocusNode = FocusNode();

  @override
  void dispose() {
    _keyboardFocusNode.dispose();
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _keyboardFocusNode,
      onKey: (RawKeyEvent event) {
        if (event.isKeyPressed(LogicalKeyboardKey.enter) && !event.isShiftPressed) {
          widget.function();
          _keyboardFocusNode.unfocus();
          _textFieldFocusNode.unfocus();
          Future.delayed(Duration(milliseconds: 1), () {
            FocusScope.of(context).requestFocus(_textFieldFocusNode);
          });
        }
    
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.115),
        decoration: BoxDecoration(
            color: kThirdColor, borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            TextField(
              focusNode: _textFieldFocusNode,
              controller: widget.textController,
              maxLines: 10,
              minLines: 1,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Ask Anything!",
                hintStyle: TextStyle(color: kFifthColor),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.image,
                        color: kFourthColor,
                      )),
                  IconButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(kFourthColor)),
                      onPressed: () {
                        widget.function();
                      },
                      icon: Icon(
                        Icons.upload_rounded,
                        color: kPrimaryColor,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
