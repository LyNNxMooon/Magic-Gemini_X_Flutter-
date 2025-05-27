import 'package:json_annotation/json_annotation.dart';
import 'package:magic_gemini_x_flutter/network/response/candidates_response.dart';
part 'gemini_ai_response.g.dart';

@JsonSerializable()
class GeminiAiResponse {
  final List<CandidatesResponse> candidates;
  final String modelVersion;
  final String responseId;

  GeminiAiResponse(
      {required this.candidates,
      required this.modelVersion,
      required this.responseId});

  factory GeminiAiResponse.fromJson(Map<String, dynamic> json) =>
      _$GeminiAiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GeminiAiResponseToJson(this);
}
