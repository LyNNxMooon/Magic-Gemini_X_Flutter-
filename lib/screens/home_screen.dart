// ignore_for_file: deprecated_member_use, avoid_print, prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:magic_gemini_x_flutter/BLoC/auth/auth_bloc.dart';
import 'package:magic_gemini_x_flutter/BLoC/auth/auth_events.dart';
import 'package:magic_gemini_x_flutter/BLoC/auth/auth_states.dart';
import 'package:magic_gemini_x_flutter/constants/colors.dart';
import 'package:magic_gemini_x_flutter/screens/login_screen.dart';
import 'package:magic_gemini_x_flutter/utils/navigation_extension.dart';
import 'package:magic_gemini_x_flutter/widgets/custom_text_field.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final authBloc = context.read<AuthBloc>();

  List unLoggedInScrollTest = [];

  List scrollTest = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20
  ];

  void ask() {
    print("Sent");
    _textController.clear();
  }

  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 1);

  final TextEditingController _textController = TextEditingController();

  int? _selectedIndex;

  bool _isChatSelected = false;

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Row(
        children: [
          BlocBuilder<AuthBloc, AuthStates>(
            builder: (context, state) {
              if (state is Authenticated) {
                return loggedInChatList();
              } else {
                return unLoggedInChatList();
              }
            },
          ),
          _isChatSelected ? chatUI() : initChatUI()
        ],
      ),
    );
  }

  Widget appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Model 1.0",
          style: TextStyle(color: kFourthColor, fontSize: 18),
        ),
        BlocConsumer<AuthBloc, AuthStates>(
          builder: (context, state) {
            if (state is UnAuthenticated) {
              return logInButton();
            } else if (state is Authenticated) {
              return profileBox(state.user.email);
            } else {
              return CupertinoActivityIndicator();
            }
          },
          listener: (context, state) {
            if (state is UnAuthenticated) {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.success(
                  message: "Log in to load your chats!",
                ),
              );
            }
          },
        )
      ],
    );
  }

  Widget logInButton() {
    return GestureDetector(
      onTap: () => context.navigateToNext(LoginScreen()),
      child: Container(
        width: 60,
        height: 30,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text(
          "Log in",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }

  Widget profileBox(String email) {
    return PopupMenuButton(
      color: kThirdColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: kFourthColor, // Border color
          width: 0.3, // Border width
        ),
      ),
      elevation: 15,
      tooltip: "Profile",
      splashRadius: 20,
      borderRadius: BorderRadius.circular(20),
      offset: const Offset(0, 50), // Adjust this to control vertical placement

      onSelected: (value) {
        if (value == 'logout') {
          authBloc.add(UserLogout());
        }
        //   // Open settings
        // }
      },

      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'email',
          child: Container(
              padding: EdgeInsets.only(top: 10, left: 10),
              width: 300,
              height: 40,
              child: Text(
                email,
                style: TextStyle(color: Colors.white),
              )),
        ),
        PopupMenuItem(
          height: 5,
          value: '',
          child: Container(
              padding: EdgeInsets.only(
                right: 10,
                left: 10,
              ),
              width: 300,
              height: 0.1,
              child: Divider(
                thickness: 0.4,
                color: kFourthColor,
              )),
        ),
        PopupMenuItem(
          value: 'settings',
          child: Container(
              padding: EdgeInsets.only(top: 10, left: 10),
              width: 300,
              height: 40,
              child: Row(
                children: [
                  Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  const Gap(10),
                  Text(
                    'settings',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )),
        ),
        PopupMenuItem(
          value: 'Terms',
          child: Container(
              padding: EdgeInsets.only(top: 10, left: 10),
              width: 300,
              height: 40,
              child: Row(
                children: [
                  Icon(
                    Icons.inventory_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  const Gap(10),
                  Text(
                    'Terms & Policies',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )),
        ),
        PopupMenuItem(
          value: 'Notes',
          child: Container(
              padding: EdgeInsets.only(top: 10, left: 10),
              width: 300,
              height: 40,
              child: Row(
                children: [
                  Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  const Gap(10),
                  Text(
                    'Release Notes',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )),
        ),
        PopupMenuItem(
          height: 5,
          value: '',
          child: Container(
              padding: EdgeInsets.only(right: 10, left: 10, top: 5),
              width: 300,
              height: 0.1,
              child: Divider(
                thickness: 0.4,
                color: kFourthColor,
              )),
        ),
        PopupMenuItem(
          value: 'logout',
          child: Container(
              padding: EdgeInsets.only(top: 10, left: 10),
              width: 300,
              height: 40,
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 18,
                  ),
                  const Gap(10),
                  Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )),
        ),
      ],
      child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: kThirdColor),
          child: Center(
            child: Text(
              "${email[0]} ${email[1]}".toUpperCase(),
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: kFourthColor),
            ),
          )),
    );
  }

  Widget initChatUI() {
    return Container(
      width: MediaQuery.of(context).size.width * 1 - 320,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          appBar(),
          Column(
            children: [
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
                      text: "M A G i C",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: "\nGemini x Flutter",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ]),
                ),
              ),
              const Gap(40),
              CustomTextField(
                textController: _textController,
                function: () {
                  ask();
                  setState(() {
                    _isChatSelected = true;
                  });
                },
              )
            ],
          ),
          Center(
            child: Text(
              "Copyright@ - Magic",
              style: TextStyle(color: kFourthColor, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }

  Widget chatUI() {
    return Container(
      width: MediaQuery.of(context).size.width * 1 - 320,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          appBar(),
          Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: CustomTextField(
              textController: _textController,
              function: () {
                ask();
                setState(() {
                  _isChatSelected = true;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget loggedInChatList() {
    return SizedBox(
        width: 320,
        height: MediaQuery.of(context).size.height * 1,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: kSecondaryColor,
                width: 320,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(right: 25, left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                            color: kFourthColor,
                          )),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _isChatSelected = false;
                            });
                          },
                          icon: Icon(
                            Icons.add_card_rounded,
                            color: kFourthColor,
                          ))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 320,
              height: MediaQuery.of(context).size.height * 1 - 60,
              child: ScrollbarTheme(
                data: ScrollbarThemeData(
                  thumbVisibility: WidgetStateProperty.all(true),
                  thumbColor: WidgetStateProperty.all(kThirdColor),
                  thickness: WidgetStateProperty.all(10.0),
                  radius: const Radius.circular(10),
                ),
                child: Scrollbar(
                  controller: _scrollController,
                  interactive: true,
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      ...scrollTest.map(
                        (e) => ListTile(
                          onTap: () {
                            setState(() {
                              _selectedIndex = scrollTest.indexOf(e);
                              _isChatSelected = true;
                            });
                          },
                          tileColor: _selectedIndex == scrollTest.indexOf(e)
                              ? kThirdColor.withOpacity(0.08)
                              : kSecondaryColor,
                          splashColor: kThirdColor.withOpacity(0.2),
                          hoverColor: kThirdColor.withOpacity(0.4),
                          title: Text(
                            e.toString(),
                            style: TextStyle(color: kFourthColor),
                          ),
                          trailing: IconButton(onPressed: () {
                            
                          }, icon: Icon(Icons.more_horiz, color: kFourthColor, size: 18,)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget unLoggedInChatList() {
    return SizedBox(
        width: 320,
        height: MediaQuery.of(context).size.height * 1,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: kSecondaryColor,
                width: 320,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(right: 25, left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                            color: kFourthColor,
                          )),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _isChatSelected = false;
                            });
                          },
                          icon: Icon(
                            Icons.add_card_rounded,
                            color: kFourthColor,
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: kSecondaryColor,
              width: 320,
              height: MediaQuery.of(context).size.height * 1 - 60,
              child: ScrollbarTheme(
                data: ScrollbarThemeData(
                  thumbVisibility: WidgetStateProperty.all(true),
                  thumbColor: WidgetStateProperty.all(kThirdColor),
                  thickness: WidgetStateProperty.all(10.0),
                  radius: const Radius.circular(10),
                ),
                child: Scrollbar(
                  controller: _scrollController,
                  interactive: true,
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      ...unLoggedInScrollTest.map(
                        (e) => ListTile(
                          onTap: () {
                            setState(() {
                              _selectedIndex = scrollTest.indexOf(e);
                            });
                          },
                          tileColor: _selectedIndex == scrollTest.indexOf(e)
                              ? kThirdColor.withOpacity(0.08)
                              : kSecondaryColor,
                          splashColor: kThirdColor.withOpacity(0.2),
                          hoverColor: kThirdColor.withOpacity(0.4),
                          title: Text(
                            e.toString(),
                            style: TextStyle(color: kFourthColor),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
