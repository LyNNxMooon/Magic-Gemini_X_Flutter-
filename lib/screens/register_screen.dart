import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:magic_gemini_x_flutter/BLoC/auth/auth_bloc.dart';
import 'package:magic_gemini_x_flutter/BLoC/auth/auth_events.dart';
import 'package:magic_gemini_x_flutter/BLoC/auth/auth_states.dart';
import 'package:magic_gemini_x_flutter/constants/colors.dart';
import 'package:magic_gemini_x_flutter/utils/navigation_extension.dart';
import 'package:magic_gemini_x_flutter/widgets/custom_button.dart';
import 'package:magic_gemini_x_flutter/widgets/custom_loading_buttton.dart';
import 'package:magic_gemini_x_flutter/widgets/login_text_field.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.toggleScreens});

  final void Function()? toggleScreens;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordObscured = true;
  late final registerBloc = context.read<RegisterBloc>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: BlocListener<RegisterBloc, RegistrationStates>(
            listener: (context, state) {
              if (state is RegisterFailed) {
                showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.error(
                    message: state.message,
                  ),
                );
              }

              if (state is RegisterSuccessful) {
                showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.success(
                    message: state.message,
                  ),
                );
                _emailController.clear();
                _passwordController.clear();
                _confirmPasswordController.clear();
                widget.toggleScreens;
              }
            },
            child: Center(
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
                              padding: EdgeInsets.only(
                                  left: 10, top: 8, bottom: 8, right: 6),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.7, color: Colors.white),
                                  borderRadius: BorderRadius.circular(30)),
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
                          text: "R E G I S T E R",
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.w600),
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
                  LoginAndRegisterTextField(
                      textController: _emailController, hintText: "Email"),
                  const Gap(15),
                  LoginAndRegisterTextField(
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
                  const Gap(15),
                  LoginAndRegisterTextField(
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
                      textController: _confirmPasswordController,
                      hintText: "Confirm Password"),
                  const Gap(40),
                  BlocBuilder<RegisterBloc, RegistrationStates>(
                    builder: (context, state) {
                      if (state is RegistrationLoading) {
                        return CustomLoadingButtton();
                      } else {
                        return CustomButton(
                          functionName: "Register",
                          function: () {
                            registerBloc.add(RegisterUser(
                                email: _emailController.text,
                                password: _passwordController.text,
                                confirmPassword:
                                    _confirmPasswordController.text));
                          },
                        );
                      }
                    },
                  ),
                  const Gap(10),
                  TextButton(
                      onPressed: widget.toggleScreens,
                      child: Text(
                        "Already have an account? Log In",
                        style: TextStyle(color: Colors.blue),
                      )),
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
            )));
  }
}
