import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic_gemini_x_flutter/data/vo/chat_list_vo.dart';
import 'package:magic_gemini_x_flutter/data/vo/content_vo.dart';
import 'package:magic_gemini_x_flutter/domain/chat_list_repository.dart';

class FirebaseChatListRepo implements ChatListRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<ContentVO>?> loadChats(String uid, int chatId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await firestore
          .collection('chats')
          .doc(uid) 
          .collection(chatId.toString()) 
          .doc('chatlist') 
          .get();

      if (!doc.exists || doc.data() == null) {
        return null;
      }

      ChatListVO result = ChatListVO.fromJson(doc.data()!);
      return result.contents;
    } catch (error) {
      throw Exception("Error fetching chats: $error");
    }
  }

  @override
  Future<void> saveChats(ChatListVO chatList) async {
    try {
      await firestore
          .collection('chats')
          .doc(chatList.uid)
          .collection(chatList.chatId.toString())
          .doc('chatlist')
          .set(chatList.toJson());
    } catch (error) {
      throw Exception("Error saving chat: $error");
    }
  }
}
