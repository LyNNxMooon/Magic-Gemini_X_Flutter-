import 'package:magic_gemini_x_flutter/data/vo/content_vo.dart';

abstract class GeminiChatRepo {
  Future<ContentVO> requestToGemini(String text);
}