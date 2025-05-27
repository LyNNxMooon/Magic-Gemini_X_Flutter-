import 'package:dio/dio.dart';
import 'package:magic_gemini_x_flutter/config/api_error_config.dart';
import 'package:magic_gemini_x_flutter/data/vo/content_vo.dart';
import 'package:magic_gemini_x_flutter/data/vo/gemini_request_vo.dart';
import 'package:magic_gemini_x_flutter/data/vo/generation_config_vo.dart';
import 'package:magic_gemini_x_flutter/data/vo/user_text_vo.dart';
import 'package:magic_gemini_x_flutter/network/api/api.dart';
import 'package:magic_gemini_x_flutter/network/api/api_constant.dart';
import 'package:magic_gemini_x_flutter/network/data_agent/data_agent.dart';

class DataAgentImpl extends DataAgent {
  late Api _api;

  DataAgentImpl._() {
    _api = Api(Dio());
  }

  static final DataAgentImpl _singleton = DataAgentImpl._();
  factory DataAgentImpl() => _singleton;

  ApiErrorConfig apiErrorsConfig = ApiErrorConfig();

  @override
  Future<ContentVO> requestToGemini(String text) async {
    try {
      UserTextVO userText = UserTextVO(text: text);
      ContentVO content =
          ContentVO(role: "user", parts: <UserTextVO>[userText]);
      GenerationConfigVO generationConfig =
          GenerationConfigVO(responseMimeType: "text/plain");
      GeminiRequestVO request = GeminiRequestVO(
          contents: <ContentVO>[content], generationConfig: generationConfig);

      return await _api
          .requestToGemini(modelID, generateContentApi, apiKey, request)
          .asStream()
          .map(
            (event) => event.candidates[0].content,
          )
          .first;
    } on Exception catch (error) {
      return Future.error(apiErrorsConfig.throwExceptionForRequest(error));
    }
  }
}
