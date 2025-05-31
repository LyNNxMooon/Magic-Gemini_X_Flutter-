abstract class ChatListEvents {}

class LoadChatList extends ChatListEvents {

  final String uid;

  LoadChatList({required this.uid});
}