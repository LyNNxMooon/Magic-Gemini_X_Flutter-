import 'package:flutter/material.dart';
import 'package:magic_gemini_x_flutter/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: const Color.fromARGB(255, 33, 107, 243), // Background color when text is selected
        ),
        fontFamily: "Roboto",
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
