// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordSettings _$PasswordSettingsFromJson(Map<String, dynamic> json) =>
    PasswordSettings(
      length: (json['length'] as num).toInt(),
      includeUppercase: json['includeUppercase'] as bool,
      includeNumbers: json['includeNumbers'] as bool,
      includeSpecialCharacters: json['includeSpecialCharacters'] as bool,
    );

Map<String, dynamic> _$PasswordSettingsToJson(PasswordSettings instance) =>
    <String, dynamic>{
      'length': instance.length,
      'includeUppercase': instance.includeUppercase,
      'includeNumbers': instance.includeNumbers,
      'includeSpecialCharacters': instance.includeSpecialCharacters,
    };
