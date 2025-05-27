
import 'package:magic_gemini_x_flutter/data/vo/content_vo.dart';

abstract class GeminiChatRepo {
  Future<List<ContentVO>> requestToGemini(String text, String uid);

}