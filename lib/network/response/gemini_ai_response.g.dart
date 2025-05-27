// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_ai_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeminiAiResponse _$GeminiAiResponseFromJson(Map<String, dynamic> json) =>
    GeminiAiResponse(
      candidates: (json['candidates'] as List<dynamic>)
          .map((e) => CandidatesResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      modelVersion: json['modelVersion'] as String,
      responseId: json['responseId'] as String,
    );

Map<String, dynamic> _$GeminiAiResponseToJson(GeminiAiResponse instance) =>
    <String, dynamic>{
      'candidates': instance.candidates,
      'modelVersion': instance.modelVersion,
      'responseId': instance.responseId,
    };
