import 'package:json_annotation/json_annotation.dart';
part 'user_text_vo.g.dart';

@JsonSerializable(explicitToJson: true)
class UserTextVO {
  final String text;

  UserTextVO({required this.text});

  factory UserTextVO.fromJson(Map<String, dynamic> json) =>
      _$UserTextVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserTextVOToJson(this);
}
