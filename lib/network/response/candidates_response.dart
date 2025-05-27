import 'package:json_annotation/json_annotation.dart';
import 'package:magic_gemini_x_flutter/data/vo/content_vo.dart';
part 'candidates_response.g.dart';

@JsonSerializable()
class CandidatesResponse {
  final ContentVO content;
  final String finishReason;

  CandidatesResponse({required this.content, required this.finishReason});

  factory CandidatesResponse.fromJson(Map<String, dynamic> json) =>
      _$CandidatesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CandidatesResponseToJson(this);
}
