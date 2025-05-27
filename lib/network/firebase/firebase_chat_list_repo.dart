import 'package:firebase_database/firebase_database.dart';
import 'package:magic_gemini_x_flutter/data/vo/chat_list_vo.dart';
import 'package:magic_gemini_x_flutter/data/vo/content_vo.dart';
import 'package:magic_gemini_x_flutter/domain/chat_list_repository.dart';

class FirebaseChatListRepo implements ChatListRepo {
  final databaseRef = FirebaseDatabase.instance.ref();

  @override
  Future<List<ContentVO>?> loadChats(String uid) async {
    try {
      return databaseRef.child("chats").child(uid).once().then(
        (value) {
   
          if (value.snapshot.value == null) {
            return null;
          }

          final rawData = value.snapshot.value;
          ChatListVO result =
              ChatListVO.fromJson(Map<String, dynamic>.from(rawData as Map));
          return result.contents;
        },
      );
    } catch (error) {
      throw Exception("Error fetching feeds: $error");
    }
  }

  @override
  Future<void> saveChats(ChatListVO chatList) async {
    try {
      await databaseRef
          .child("chats")
          .child(chatList.uid)
          .set(chatList.toJson());
    } catch (error) {
      throw Exception("Error saving chat: $error");
    }
  }
}
