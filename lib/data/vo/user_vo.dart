
import 'package:json_annotation/json_annotation.dart';
part 'user_vo.g.dart';

@JsonSerializable()
class UserVO {
  final String uid;
  String email;

  UserVO({required this.uid, required this.email});

  factory UserVO.fromJson(Map<String, dynamic> json) =>
      _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);
}
