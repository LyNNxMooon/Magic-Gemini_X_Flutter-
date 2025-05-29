import 'package:magic_gemini_x_flutter/data/vo/chat_list_vo.dart';
import 'package:magic_gemini_x_flutter/data/vo/content_vo.dart';

abstract class ChatListRepo {
  Future<void> saveChats(ChatListVO chatList);
  Future<List<ContentVO>?> loadChats(String uid, int chatId);
}