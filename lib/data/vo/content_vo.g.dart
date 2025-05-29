// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentVO _$ContentVOFromJson(Map<String, dynamic> json) => ContentVO(
      role: json['role'] as String,
      parts: (json['parts'] as List<dynamic>)
          .map((e) => UserTextVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContentVOToJson(ContentVO instance) => <String, dynamic>{
      'role': instance.role,
      'parts': instance.parts.map((e) => e.toJson()).toList(),
    };
