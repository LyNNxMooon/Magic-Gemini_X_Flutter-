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
          .collection('userChats')
          .doc(chatId.toString())
          .get();

      if (!doc.exists || doc.data() == null) {
        return null;
      }

      ChatListVO result = ChatListVO.fromJson(doc.data()!);
      return result.contents;
    } on FirebaseException catch (error) {
      return Future.error("Error fetching chats: $error");
    }
  }

  @override
  Future<void> saveChats(ChatListVO chatList) async {
    try {
      await firestore
          .collection('chats')
          .doc(chatList.uid)
          .collection('userChats')
          .doc(chatList.chatId.toString())
          .set(chatList.toJson(), SetOptions(merge: true));
    } on FirebaseException catch (error) {
      return Future.error("Error saving chats: $error");
    }
  }

  @override
  Future<List<ChatListVO>> loadChatList(String uid) async {
    try {
      final indexDoc = await firestore
          .collection('chats')
          .doc(uid)
          .collection('userChats')
          .get();

      if (indexDoc.docs.isEmpty) return [];

      List<ChatListVO> allChats = [];

      for (var doc in indexDoc.docs) {
        final data = doc.data();
        final chatVO = ChatListVO.fromJson(data);
        allChats.add(chatVO);
      }

      return allChats;
    } on FirebaseException catch (error) {
      return Future.error("Error loading chat list : $error");
    }
  }
}
