// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_list_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatListVO _$ChatListVOFromJson(Map<String, dynamic> json) => ChatListVO(
      uid: json['uid'] as String,
      chatId: (json['chatId'] as num).toInt(),
      contents: (json['contents'] as List<dynamic>)
          .map((e) => ContentVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      //timestamp: (json['timestamp'] as Timestamp).toDate()
    );

Map<String, dynamic> _$ChatListVOToJson(ChatListVO instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'chatId': instance.chatId,
      'contents': instance.contents.map((e) => e.toJson()).toList(),
      'timestamp': instance.timestamp.toIso8601String(),
    };
