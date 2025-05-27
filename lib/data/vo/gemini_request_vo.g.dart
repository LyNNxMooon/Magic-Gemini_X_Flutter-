// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeminiRequestVO _$GeminiRequestVOFromJson(Map<String, dynamic> json) =>
    GeminiRequestVO(
      contents: (json['contents'] as List<dynamic>)
          .map((e) => ContentVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      generationConfig: GenerationConfigVO.fromJson(
          json['generationConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeminiRequestVOToJson(GeminiRequestVO instance) =>
    <String, dynamic>{
      'contents': instance.contents,
      'generationConfig': instance.generationConfig,
    };
