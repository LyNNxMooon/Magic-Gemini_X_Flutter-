abstract class ChatEvents {}

class AskGemini extends ChatEvents {
  final String text;
  final String uid;
  final int? chatId;

  AskGemini({required this.text, required this.uid, required this.chatId});
}


class LoadChats extends ChatEvents {

  final String uid;
  final String chatId;

  LoadChats({required this.chatId, required this.uid});
}

