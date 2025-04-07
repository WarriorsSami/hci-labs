import 'package:credentials_generator/features/passwords_generator/models/password_settings.dart';
import 'package:json_annotation/json_annotation.dart';

part 'password_data.g.dart';

@JsonSerializable()
class PasswordData {
  final String password;
  final PasswordSettings settings;

  PasswordData({required this.password, required this.settings});

  PasswordData copyWith({String? password, PasswordSettings? settings}) {
    return PasswordData(
      password: password ?? this.password,
      settings: settings ?? this.settings,
    );
  }

  factory PasswordData.fromJson(Map<String, dynamic> json) =>
      _$PasswordDataFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordDataToJson(this);
}
