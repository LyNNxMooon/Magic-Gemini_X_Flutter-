import 'package:magic_gemini_x_flutter/data/vo/chat_list_vo.dart';

abstract class ChatListStates {}

class InitChatList extends ChatListStates {}

class ChatListLoading extends ChatListStates {}

class ChatListLoaded extends ChatListStates {
  final List<ChatListVO> chats;

  ChatListLoaded ({required this.chats});
}

class ChatListError extends ChatListStates {
  final String message;

  ChatListError ({required this.message});
}