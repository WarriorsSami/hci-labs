import 'package:json_annotation/json_annotation.dart';

part 'password_settings.g.dart';

@JsonSerializable()
class PasswordSettings {
  final int length;
  final bool includeUppercase;
  final bool includeNumbers;
  final bool includeSpecialCharacters;

  PasswordSettings({
    required this.length,
    required this.includeUppercase,
    required this.includeNumbers,
    required this.includeSpecialCharacters,
  });

  PasswordSettings copyWith({
    int? length,
    bool? includeUppercase,
    bool? includeNumbers,
    bool? includeSpecialCharacters,
  }) {
    return PasswordSettings(
      length: length ?? this.length,
      includeUppercase: includeUppercase ?? this.includeUppercase,
      includeNumbers: includeNumbers ?? this.includeNumbers,
      includeSpecialCharacters:
          includeSpecialCharacters ?? this.includeSpecialCharacters,
    );
  }

  factory PasswordSettings.fromJson(Map<String, dynamic> json) =>
      _$PasswordSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordSettingsToJson(this);
}
