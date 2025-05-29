import 'package:magic_gemini_x_flutter/data/vo/content_vo.dart';

abstract class ChatStates {}

class InitChat extends ChatStates {}

class ChatLoading extends ChatStates {}

class ChatLoaded extends ChatStates {
  final List<ContentVO> contents;

  ChatLoaded ({required this.contents});
}

class ChatError extends ChatStates {
  final String message;

  ChatError ({required this.message});
}