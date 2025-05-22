import 'package:flutter/material.dart';
import 'package:magic_gemini_x_flutter/app.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

   WindowOptions windowOptions = const WindowOptions(
    size: Size(1400, 800),
    minimumSize: Size(1400, 800),
    maximumSize: Size(1400, 800),
    center: true,
    title: "Magic",
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.setPreventClose(false);
    await windowManager.setMaximizable(false);
  });

  runApp(const MyApp());
}


