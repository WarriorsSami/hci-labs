// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensitive_text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SensitiveText _$SensitiveTextFromJson(Map<String, dynamic> json) =>
    SensitiveText(
      inputText: json['inputText'] as String,
      anonymizedText: json['anonymizedText'] as String,
    );

Map<String, dynamic> _$SensitiveTextToJson(SensitiveText instance) =>
    <String, dynamic>{
      'inputText': instance.inputText,
      'anonymizedText': instance.anonymizedText,
    };
