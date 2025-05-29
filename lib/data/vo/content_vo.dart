import 'package:json_annotation/json_annotation.dart';
import 'package:magic_gemini_x_flutter/data/vo/user_text_vo.dart';
part 'content_vo.g.dart';

@JsonSerializable(explicitToJson:  true)
class ContentVO {
  final String role;
  final List<UserTextVO> parts;

  ContentVO({required this.role, required this.parts});


  factory ContentVO.fromJson(Map<String, dynamic> json) =>
      _$ContentVOFromJson(json);

  Map<String, dynamic> toJson() => _$ContentVOToJson(this);
}