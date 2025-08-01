import 'package:dio/dio.dart';
import 'package:magic_gemini_x_flutter/config/api_error_config.dart';
import 'package:magic_gemini_x_flutter/data/model/chat_list_model.dart';
import 'package:magic_gemini_x_flutter/data/vo/chat_list_vo.dart';
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

  final chatListModel = ChatListModel();

  @override
  Future<String> requestToGemini(String text, String uid, int chatId) async {
    try {

      //check user
      String userID =
          uid.isEmpty ? DateTime.now().millisecondsSinceEpoch.toString() : uid;
   
      //load chats
      List<ContentVO>? contents = await chatListModel.loadChats(userID, chatId.toString());

      //Construct Objs to request to Gemini
      UserTextVO userText = UserTextVO(text: text);
      ContentVO requestedContent =
          ContentVO(role: "user", parts: <UserTextVO>[userText]);
      GenerationConfigVO generationConfig =
          GenerationConfigVO(responseMimeType: "text/plain");

      //Add to the previous contents to keep the conversation with Gemini
      contents!.add(requestedContent);
      
      //Final Requesting obj for Gemini
      GeminiRequestVO request = GeminiRequestVO(
          contents: contents,
          generationConfig: generationConfig);

      //request to gemini api
      ContentVO geminiContent = await _api
          .requestToGemini(modelID, generateContentApi, apiKey, request)
          .asStream()
          .map(
            (event) => event.candidates[0].content,
          )
          .first;

      //save gemini content to local loaded list
      contents.add(geminiContent);

      //create new chat list with updated content list
      ChatListVO newChatList = ChatListVO(uid: userID, chatId: chatId ,contents: contents, timestamp: DateTime.now());

      //save list to Firebase
      chatListModel.saveChats(newChatList);

      return chatId.toString();
    } on Exception catch (error) {
      return Future.error(apiErrorsConfig.throwExceptionForRequest(error));
    }
  }
}
