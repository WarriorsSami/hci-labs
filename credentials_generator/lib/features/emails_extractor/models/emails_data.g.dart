// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emails_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailsData _$EmailsDataFromJson(Map<String, dynamic> json) => EmailsData(
  inputText: json['inputText'] as String,
  emails: (json['emails'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$EmailsDataToJson(EmailsData instance) =>
    <String, dynamic>{
      'inputText': instance.inputText,
      'emails': instance.emails,
    };
