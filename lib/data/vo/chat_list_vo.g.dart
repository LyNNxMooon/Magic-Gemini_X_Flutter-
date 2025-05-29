// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_list_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatListVO _$ChatListVOFromJson(Map<String, dynamic> json) => ChatListVO(
      uid: json['uid'] as String,
      contents: (json['contents'] as List<dynamic>)
          .map((e) => ContentVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatListVOToJson(ChatListVO instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'contents': instance.contents.map((e) => e.toJson()).toList(),
    };
