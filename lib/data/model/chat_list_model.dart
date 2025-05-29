import 'package:magic_gemini_x_flutter/data/vo/chat_list_vo.dart';
import 'package:magic_gemini_x_flutter/data/vo/content_vo.dart';
import 'package:magic_gemini_x_flutter/domain/chat_list_repository.dart';
import 'package:magic_gemini_x_flutter/network/firebase/firebase_chat_list_repo.dart';

class ChatListModel implements ChatListRepo {
  ChatListModel._();
  static final ChatListModel _singleton = ChatListModel._();
  factory ChatListModel() => _singleton;
  final _firebaseAgent = FirebaseChatListRepo();

  @override
  Future<List<ContentVO>?> loadChats(String uid, int chatId) async {
    try {
      
      var result = await _firebaseAgent.loadChats(uid, chatId);

      if (result == null) {
        return <ContentVO>[];
      } else {
        return result;
      }
      
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  @override
  Future<void> saveChats(ChatListVO chatList) async {
    try {
      return await _firebaseAgent.saveChats(chatList);
    } on Exception catch (error) {
      return Future.error(error);
    }
  }
}
