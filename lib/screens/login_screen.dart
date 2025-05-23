import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:magic_gemini_x_flutter/constants/colors.dart';
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
            Expanded(child: SizedBox()),
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
                function: () {},
                hintText: "Email"),
            const Gap(15),
            LoginTextField(
              isObscure: _isPasswordObscured,
              suffixIcon: _isPasswordObscured ? IconButton(onPressed: () {
                setState(() {
                  _isPasswordObscured = !_isPasswordObscured;
                });
              }, icon: Icon(Icons.visibility_off, color: kFourthColor,)) : IconButton(onPressed: () {
                  setState(() {
                  _isPasswordObscured = !_isPasswordObscured;
                });
              }, icon: Icon(Icons.visibility, color: kFourthColor,)),
                textController: _passwordController,
                function: () {},
                hintText: "Password"),
            const Gap(40),
            CustomButton(
              functionName: "Log in",
              funtion: () {},
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
