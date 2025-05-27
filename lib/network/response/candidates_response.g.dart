// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidates_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CandidatesResponse _$CandidatesResponseFromJson(Map<String, dynamic> json) =>
    CandidatesResponse(
      content: ContentVO.fromJson(json['content'] as Map<String, dynamic>),
      finishReason: json['finishReason'] as String,
    );

Map<String, dynamic> _$CandidatesResponseToJson(CandidatesResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
      'finishReason': instance.finishReason,
    };
