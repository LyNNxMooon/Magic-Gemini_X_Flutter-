
import 'package:dio/dio.dart' hide Headers;
import 'package:magic_gemini_x_flutter/data/vo/gemini_request_vo.dart';
import 'package:magic_gemini_x_flutter/network/api/api_constant.dart';
import 'package:magic_gemini_x_flutter/network/response/gemini_ai_response.dart';
import 'package:retrofit/retrofit.dart';
part 'api.g.dart';

@RestApi(baseUrl: kBaseURL)
abstract class Api {

  factory Api(Dio dio) => _Api(dio);

  @POST(kEndPointForTextGeneration)
  @Headers(<String, dynamic>{
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  })
  Future<GeminiAiResponse> requestToGemini(
     @Path(kPathParameterForModelID) String modelID,
     @Path(kPathParameterForGenerateContentApi) String generateContentApi,
     @Query(kParamKeyForApiKey) String apiKey,
     @Body() GeminiRequestVO request
  );
}