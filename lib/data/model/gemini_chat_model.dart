import 'package:magic_gemini_x_flutter/data/vo/content_vo.dart';
import 'package:magic_gemini_x_flutter/domain/gemini_chat_repository.dart';
import 'package:magic_gemini_x_flutter/network/data_agent/data_agent.dart';
import 'package:magic_gemini_x_flutter/network/data_agent/data_agent_impl.dart';

class GeminiChatModel implements GeminiChatRepo {
  GeminiChatModel._();
  static final GeminiChatModel _singleton = GeminiChatModel._();
  factory GeminiChatModel() => _singleton;

  final DataAgent _dataAgent = DataAgentImpl();

  @override
  Future<List<ContentVO>> requestToGemini(
      String text, String uid, int? chatId) async {
    try {
      var result = await _dataAgent.requestToGemini(
          text, uid, chatId ?? DateTime.now().millisecondsSinceEpoch);

      if (result == null) {
        return <ContentVO>[];
      }

      return result;
    } on Exception catch (error) {
      return Future.error(error);
    }
  }
}
