// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordData _$PasswordDataFromJson(Map<String, dynamic> json) => PasswordData(
  password: json['password'] as String,
  settings: PasswordSettings.fromJson(json['settings'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PasswordDataToJson(PasswordData instance) =>
    <String, dynamic>{
      'password': instance.password,
      'settings': instance.settings,
    };
