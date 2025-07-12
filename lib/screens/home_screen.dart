// ignore_for_file: deprecated_member_use, avoid_print, prefer_final_fields, unused_field

import 'dart:async';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
//import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:magic_gemini_x_flutter/BLoC/auth/auth_bloc.dart';
import 'package:magic_gemini_x_flutter/BLoC/auth/auth_events.dart';
import 'package:magic_gemini_x_flutter/BLoC/auth/auth_states.dart';
import 'package:magic_gemini_x_flutter/BLoC/chat_list/chat_list_bloc.dart';
import 'package:magic_gemini_x_flutter/BLoC/chat_list/chat_list_events.dart';
import 'package:magic_gemini_x_flutter/BLoC/chat_list/chat_list_states.dart';
import 'package:magic_gemini_x_flutter/BLoC/gemini_chat/chat_bloc.dart';
import 'package:magic_gemini_x_flutter/BLoC/gemini_chat/chat_events.dart';
import 'package:magic_gemini_x_flutter/BLoC/gemini_chat/chat_states.dart';
import 'package:magic_gemini_x_flutter/constants/colors.dart';
import 'package:magic_gemini_x_flutter/data/vo/chat_list_vo.dart';
import 'package:magic_gemini_x_flutter/data/vo/content_vo.dart';
import 'package:magic_gemini_x_flutter/screens/login_screen.dart';
import 'package:magic_gemini_x_flutter/utils/navigation_extension.dart';
import 'package:magic_gemini_x_flutter/widgets/custom_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final authBloc = context.read<AuthBloc>();
  late final chatBloc = context.read<ChatBloc>();
  late final chatListBloc = context.read<ChatListBloc>();
  late final askGeminiBloc = context.read<AskGeminiBloc>();

  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 1);

  final TextEditingController _textController = TextEditingController();

  int? _selectedIndex = -1;

  bool _isChatSelected = false;
  bool _isViewingChats = false;

  Timer? _delayTimer;

  int? _chatId;

  Future askGeminiFromChat(int? chatId) async {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? "";
    askGeminiBloc
        .add(AskGemini(text: _textController.text, uid: uid, chatId: chatId));

    _textController.clear();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  String getDateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final other = DateTime(date.year, date.month, date.day);
    final diff = today.difference(other).inDays;

    if (diff == 0) return "Today";
    if (diff == 1) return "Yeterday";
    if (diff <= 7) return "Last 7 days";
    if (now.year == date.year) {
      return DateFormat.MMMM().format(date);
    }

    return "Last Year";
  }

  final groupedChats = <String, List<ChatListVO>>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Row(
        children: [
          BlocConsumer<AuthBloc, AuthStates>(
            builder: (context, state) {
              if (state is Authenticated) {
                return loggedInChatList();
              } else {
                return unLoggedInChatList();
              }
            },
            listener: (context, state) {
              if (state is Authenticated) {
                setState(() {
                  _isChatSelected = false;
                  _isViewingChats = false;
                });
                chatListBloc.add(LoadChatList(
                    uid: FirebaseAuth.instance.currentUser?.uid ?? ""));
              }
            },
          ),
          BlocListener<AskGeminiBloc, AskToGeminiStates>(
              listener: (context, state) {
                if (state is SavedChat) {
                  chatListBloc.add(LoadChatList(
                      uid: FirebaseAuth.instance.currentUser?.uid ?? ""));
                }
              },
              child: _isChatSelected && _isViewingChats
                  ? chatsViewUI()
                  : _isChatSelected && !_isViewingChats
                      ? chatUI()
                      : initChatUI())
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
        BlocBuilder<AuthBloc, AuthStates>(
          builder: (context, state) {
            if (state is UnAuthenticated) {
              return logInButton();
            } else if (state is Authenticated) {
              return profileBox(state.user.email);
            } else {
              return CupertinoActivityIndicator();
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
          setState(() {
            _isChatSelected = false;
            _isViewingChats = false;
          });
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
                function: () async {
                  setState(() {
                    _isChatSelected = true;
                    _isViewingChats = false;
                  });
                  await askGeminiFromChat(null);
                  _delayTimer = Timer(Duration(seconds: 4), () {
                    if (mounted) {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    }
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
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          appBar(),
          Expanded(
            child: BlocConsumer<AskGeminiBloc, AskToGeminiStates>(
              builder: (context, state) {
                if (state is GeminiThinking) {
                  return geminiThinkingLoadingWidget();
                }

                if (state is SavedChat) {
                  return BlocBuilder<ChatBloc, ChatStates>(
                    builder: (context, state) {
                      if (state is ChatLoading) {
                        return loadingWidget();
                      }

                      if (state is ChatLoaded) {
                        return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.115,
                            ),
                            child: ListView(
                              reverse: true,
                              children: state.contents.reversed
                                  .toList()
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                final index = entry.key;
                                final content = entry.value;
                                final isLastMessage =
                                    index != state.contents.length - 1;

                                return WipeRevealMessage(
                                  isLastMessage: isLastMessage,
                                  duration: Duration(milliseconds: 1000),
                                  child: messageItemView(content),
                                );
                              }).toList(),
                            ));
                      }

                      if (state is ChatError) {
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            state.message,
                            style: TextStyle(color: kFourthColor, fontSize: 20),
                          ),
                        );
                      }

                      return SizedBox();
                    },
                  );
                }

                if (state is AskingGeminiError) {
                  return Align(
                    alignment: Alignment.center,
                    child: Text(
                      state.message,
                      style: TextStyle(color: kFourthColor, fontSize: 20),
                    ),
                  );
                }

                return SizedBox();
              },
              listener: (context, state) {
                if (state is SavedChat) {
                  _chatId = int.parse(state.chatID);
                  chatBloc.add(LoadChats(
                      chatId: state.chatID,
                      uid: FirebaseAuth.instance.currentUser?.uid ?? ""));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: CustomTextField(
              textController: _textController,
              function: () {
                askGeminiFromChat(_chatId);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget chatsViewUI() {
    return Container(
      width: MediaQuery.of(context).size.width * 1 - 320,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          appBar(),
          Expanded(child: BlocBuilder<ChatBloc, ChatStates>(
            builder: (context, state) {
              if (state is ChatLoading) {
                return loadingWidget();
              }

              if (state is ChatLoaded) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.115,
                  ),
                  child: ListView(
                    reverse: true,
                    children: state.contents.reversed
                        .toList()
                        .asMap()
                        .entries
                        .map((entry) {
                      final index = entry.key;
                      final content = entry.value;
                      final isLastMessage = index != state.contents.length - 1;

                      return WipeRevealMessage(
                        isLastMessage: isLastMessage,
                        duration: Duration(milliseconds: 1000),
                        child: messageItemView(content),
                      );
                    }).toList(),
                  ),
                );
              }

              if (state is ChatError) {
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    state.message,
                    style: TextStyle(color: kFourthColor, fontSize: 20),
                  ),
                );
              }

              return SizedBox();
            },
          )),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: CustomTextField(
              textController: _textController,
              function: () {
                askGeminiFromChat(_chatId);
                setState(() {
                  _isViewingChats = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget messageItemView(ContentVO content) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      alignment:
          content.role == "user" ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
            left: content.role == "user"
                ? MediaQuery.of(context).size.width * 0.2
                : 0),
        padding: content.role == "user"
            ? EdgeInsets.symmetric(horizontal: 20, vertical: 10)
            : EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: content.role == "user"
              ? kFifthColor.withOpacity(0.2)
              : Colors.transparent,
        ),
        child: Text(
          content.parts[0].text,
          style: TextStyle(color: kFourthColor, fontSize: 16),
        ),
      ),
    );
  }

  Widget geminiThinkingLoadingWidget() {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.115,
            vertical: 60),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 46, right: 40),
                child: Text(
                  "T h i n k i n g",
                  style: TextStyle(
                      color: kFourthColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 310,
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: LottieBuilder.asset(
                    "assets/animations/thinking.json",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget loadingWidget() {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.115,
            vertical: 60),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Stack(
            children: [
              SizedBox(
                width: 310,
                height: 130,
                child: LottieBuilder.asset(
                  "assets/animations/thinking.json",
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ));
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
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                chatListBloc.add(LoadChatList(
                                    uid: FirebaseAuth
                                            .instance.currentUser?.uid ??
                                        ""));
                              },
                              icon: Icon(
                                Icons.replay_outlined,
                                color: kFourthColor,
                              )),
                          const Gap(10),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _isChatSelected = false;
                                  _selectedIndex = -1;
                                });
                              },
                              icon: Icon(
                                Icons.add_card_rounded,
                                color: kFourthColor,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<ChatListBloc, ChatListStates>(
              builder: (context, state) {
                if (state is ChatListLoaded) {

                   groupedChats.clear();

                  for (ChatListVO chat in state.chats) {
                    final label = getDateLabel(chat.timestamp);
                    groupedChats.putIfAbsent(label, () => []).add(chat);
                  }

                  final sortedLabels = groupedChats.keys.toList()
                    ..sort((a, b) {
                      final dateA = groupedChats[a]!.first.timestamp;
                      final dateB = groupedChats[b]!.first.timestamp;
                      return dateB.compareTo(dateA);
                    });

                  return Container(
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
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.all(4),
                          itemCount: sortedLabels.length,
                          itemBuilder: (context, index) {
                            final label = sortedLabels[index];
                            final chatsUnderLabel = groupedChats[label]!;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    label,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 128, 127, 127),
                                      
                                    ),
                                  ),
                                ),
                                ...chatsUnderLabel.map(
                                  (e) => Card(
                                    elevation:
                                        _selectedIndex == state.chats.indexOf(e)
                                            ? 4
                                            : 0,
                                    color:
                                        _selectedIndex == state.chats.indexOf(e)
                                            ? kFifthColor.withOpacity(0.2)
                                            : kSecondaryColor,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 4),
                                    child: ListTile(
                                      onTap: () {
                                        setState(() {
                                          _selectedIndex =
                                              state.chats.indexOf(e);
                                          _isChatSelected = true;
                                          _isViewingChats = true;
                                          _chatId = e.chatId;
                                          chatBloc.add(LoadChats(
                                              chatId: e.chatId.toString(),
                                              uid: FirebaseAuth.instance
                                                      .currentUser?.uid ??
                                                  ""));
                                        });
                                      },
                                      splashColor: kThirdColor.withOpacity(0.4),
                                      hoverColor: kThirdColor.withOpacity(0.3),
                                      title: Text(
                                        e.contents[0].parts[0].text.length > 20
                                            ? "${e.contents[0].parts[0].text.substring(0, 20)} ..."
                                            : e.contents[0].parts[0].text,
                                        style: TextStyle(color: kFourthColor),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.more_horiz,
                                          color: kFourthColor,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(16)
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  );
                } else if (state is ChatListError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: kFourthColor),
                    ),
                  );
                } else {
                  return Container(
                    width: 320,
                    height: MediaQuery.of(context).size.height * 1 - 60,
                    color: kSecondaryColor,
                  );
                }
              },
            )
          ],
        ));
  }

  Widget unLoggedInChatList() {
    return Container(
        color: kSecondaryColor,
        width: 320,
        height: MediaQuery.of(context).size.height * 1,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 320,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(right: 25, left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _isChatSelected = false;
                            });
                          },
                          icon: Icon(
                            Icons.add_card_rounded,
                            color: kFourthColor,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Gap(MediaQuery.of(context).size.height * 0.35),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                  text: "L O G I N",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: kThirdColor),
                ),
                TextSpan(
                  text: "\nTo Load Your Chats!",
                  style: TextStyle(
                      fontSize: 16,
                      color: kThirdColor,
                      fontWeight: FontWeight.w500),
                )
              ]),
            ),
          ],
        ));
  }
}

class WipeRevealMessage extends StatefulWidget {
  final Widget child;
  final bool isLastMessage;
  final Duration duration;

  const WipeRevealMessage({
    super.key,
    required this.child,
    required this.isLastMessage,
    this.duration = const Duration(milliseconds: 20000),
  });

  @override
  State<WipeRevealMessage> createState() => _WipeRevealMessageState();
}

class _WipeRevealMessageState extends State<WipeRevealMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    if (widget.isLastMessage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _animationController.forward();
        }
      });
    } else {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(WipeRevealMessage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isLastMessage && !oldWidget.isLastMessage) {
      _animationController.reset();
      _animationController.forward();
    } else if (!widget.isLastMessage && oldWidget.isLastMessage) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLastMessage) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: _animation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}
