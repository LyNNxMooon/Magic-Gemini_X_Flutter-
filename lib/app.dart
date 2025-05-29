import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_gemini_x_flutter/BLoC/auth/auth_bloc.dart';
import 'package:magic_gemini_x_flutter/BLoC/auth/auth_events.dart';
import 'package:magic_gemini_x_flutter/BLoC/gemini_chat/chat_bloc.dart';
import 'package:magic_gemini_x_flutter/data/model/auth_model.dart';
import 'package:magic_gemini_x_flutter/data/model/gemini_chat_model.dart';
import 'package:magic_gemini_x_flutter/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final authRepo = AuthModel();
  final geminiChatRepo = GeminiChatModel();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authRepo: authRepo)..add(CheckAuth()),
          ),
          BlocProvider<ChatBloc>(
            create: (context) => ChatBloc(geminiChatRepo: geminiChatRepo),
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
