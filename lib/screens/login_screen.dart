// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:magic_gemini_x_flutter/BLoC/auth/auth_bloc.dart';
import 'package:magic_gemini_x_flutter/BLoC/auth/auth_events.dart';
import 'package:magic_gemini_x_flutter/constants/colors.dart';
import 'package:magic_gemini_x_flutter/utils/navigation_extension.dart';
import 'package:magic_gemini_x_flutter/widgets/custom_button.dart';
import 'package:magic_gemini_x_flutter/widgets/login_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordObscured = true;
  late final authBloc = context.read<AuthBloc>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                     
                      onPressed: () => context.navigateBack(),
                      icon: Container(
                        padding: EdgeInsets.only(left: 10, top: 8, bottom: 8, right: 6),
                        decoration: BoxDecoration(border: Border.all(width: 0.7, color: Colors.white), borderRadius: BorderRadius.circular(30)),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: kFourthColor,
                        ),
                      ))
                ],
              ),
            )),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(colors: [
                Color.fromARGB(255, 23, 37, 235),
                Color.fromARGB(255, 33, 89, 243),
                Colors.lightBlue,
                kFourthColor,
              ]).createShader(bounds),
              blendMode: BlendMode.srcIn,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                    text: "L O G i N",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: "\nAnd Expand Your Magic",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  )
                ]),
              ),
            ),
            const Gap(50),
            LoginTextField(
                textController: _emailController,
             
                hintText: "Email"),
            const Gap(15),
            LoginTextField(
                isObscure: _isPasswordObscured,
                suffixIcon: _isPasswordObscured
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordObscured = !_isPasswordObscured;
                          });
                        },
                        icon: Icon(
                          Icons.visibility_off,
                          color: kFourthColor,
                        ))
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordObscured = !_isPasswordObscured;
                          });
                        },
                        icon: Icon(
                          Icons.visibility,
                          color: kFourthColor,
                        )),
                textController: _passwordController,
              
                hintText: "Password"),
            const Gap(40),
            CustomButton(
              functionName: "Log in",
              function: () {
                  authBloc.add(UserLogin(email: _emailController.text, password: _passwordController.text));
              },
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Copyright@ - Magic",
                    style: TextStyle(color: kFourthColor, fontSize: 12),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
