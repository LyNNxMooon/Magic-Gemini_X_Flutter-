abstract class ChatEvents {}

class AskGemini extends ChatEvents {
  final String text;
  final String uid;

  AskGemini({required this.text, required this.uid});
}

class LoadChats extends ChatEvents {}

class SaveChat extends ChatEvents {}