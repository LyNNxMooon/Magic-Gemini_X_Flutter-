import 'package:json_annotation/json_annotation.dart';
import 'package:magic_gemini_x_flutter/data/vo/content_vo.dart';
part 'chat_list_vo.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatListVO {
  final String uid;
  final int chatId;
  final List<ContentVO> contents;

  ChatListVO({required this.uid, required this.chatId ,required this.contents});

  factory ChatListVO.fromJson(Map<String, dynamic> json) =>
      _$ChatListVOFromJson(json);

  Map<String, dynamic> toJson() => _$ChatListVOToJson(this);
}
