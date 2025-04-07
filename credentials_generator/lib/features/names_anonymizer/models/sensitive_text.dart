import 'package:json_annotation/json_annotation.dart';

part 'sensitive_text.g.dart';

@JsonSerializable()
class SensitiveText {
  final String inputText;
  final String anonymizedText;

  SensitiveText({required this.inputText, required this.anonymizedText});

  factory SensitiveText.fromJson(Map<String, dynamic> json) =>
      _$SensitiveTextFromJson(json);

  Map<String, dynamic> toJson() => _$SensitiveTextToJson(this);
}
