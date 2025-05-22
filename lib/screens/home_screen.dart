// ignore_for_file: deprecated_member_use, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:magic_gemini_x_flutter/constants/colors.dart';
import 'package:magic_gemini_x_flutter/constants/images.dart';
import 'package:magic_gemini_x_flutter/widgets/custom_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        children: [chatList(), _isChatSelected ? chatUI() : initChatUI()],
      ),
    );
  }

  Widget initChatUI() {
    return Container(
      width: MediaQuery.of(context).size.width * 1 - 320,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Model 1.0",
                style: TextStyle(color: kFourthColor, fontSize: 18),
              ),
              Container(
                width: 35,
                height: 35,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: kProfilePlaceHolder,
                    placeholder: (context, url) => CupertinoActivityIndicator(
                      radius: 10,
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      size: 12,
                    ),
                  ),
                ),
              )
            ],
          ),
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
                          TextStyle(fontSize: 50, fontWeight: FontWeight.w700),
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
                    function: ask,
                    
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
    return SizedBox();
  }

  Widget chatList() {
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
                height: 50,
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
                          onPressed: () {},
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
              height: MediaQuery.of(context).size.height * 1 - 50,
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
