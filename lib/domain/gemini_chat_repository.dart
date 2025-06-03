

abstract class GeminiChatRepo {
  Future<String> requestToGemini(String text, String uid, int? chatId);

}