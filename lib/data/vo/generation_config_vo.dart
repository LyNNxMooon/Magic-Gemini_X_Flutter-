
import 'package:json_annotation/json_annotation.dart';
part 'generation_config_vo.g.dart';

@JsonSerializable()
class GenerationConfigVO {
  final String responseMimeType;

  GenerationConfigVO({required this.responseMimeType});

   factory GenerationConfigVO.fromJson(Map<String, dynamic> json) =>
      _$GenerationConfigVOFromJson(json);

  Map<String, dynamic> toJson() => _$GenerationConfigVOToJson(this);
}