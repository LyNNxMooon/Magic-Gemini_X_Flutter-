import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_gemini_x_flutter/BLoC/auth/auth_bloc.dart';
import 'package:magic_gemini_x_flutter/BLoC/chat_list/chat_list_bloc.dart';
import 'package:magic_gemini_x_flutter/BLoC/gemini_chat/chat_bloc.dart';
import 'package:magic_gemini_x_flutter/data/model/auth_model.dart';
import 'package:magic_gemini_x_flutter/data/model/chat_list_model.dart';
import 'package:magic_gemini_x_flutter/data/model/gemini_chat_model.dart';
import 'package:magic_gemini_x_flutter/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final authRepo = AuthModel();
  final geminiChatRepo = GeminiChatModel();
  final chatListRepo = ChatListModel();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authRepo: authRepo)
          ),
          BlocProvider<ChatBloc>(
            create: (context) => ChatBloc(chatListRepo: chatListRepo),
          ),
          BlocProvider<ChatListBloc>(
            create: (context) => ChatListBloc(chatListRepo: chatListRepo),
          ),
          BlocProvider<AskGeminiBloc>(
            create: (context) => AskGeminiBloc(geminiChatRepo: geminiChatRepo),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: const Color.fromARGB(
                  255, 33, 107, 243), // Background color when text is selected
            ),
            fontFamily: "Roboto",
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        ));
  }
}
