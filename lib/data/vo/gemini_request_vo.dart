import 'package:json_annotation/json_annotation.dart';
import 'package:magic_gemini_x_flutter/data/vo/content_vo.dart';
import 'package:magic_gemini_x_flutter/data/vo/generation_config_vo.dart';
part 'gemini_request_vo.g.dart';

@JsonSerializable(explicitToJson:  true)
class GeminiRequestVO {
  final List<ContentVO> contents;
  final GenerationConfigVO generationConfig;

  GeminiRequestVO({required this.contents, required this.generationConfig});

  factory GeminiRequestVO.fromJson(Map<String, dynamic> json) =>
      _$GeminiRequestVOFromJson(json);

  Map<String, dynamic> toJson() => _$GeminiRequestVOToJson(this);
}
