import 'package:json_annotation/json_annotation.dart';

part 'emails_data.g.dart';

@JsonSerializable()
class EmailsData {
  final String inputText;
  final List<String> emails;

  EmailsData({required this.inputText, required this.emails});

  factory EmailsData.fromText(String inputText) {
    final emails = <String>[];
    final emailRegex = RegExp(
      r'([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})',
    );
    final matches = emailRegex.allMatches(inputText);

    for (final match in matches) {
      final email = match.group(0);
      if (email != null) {
        emails.add(email);
      }
    }

    return EmailsData(inputText: inputText, emails: emails);
  }

  factory EmailsData.fromJson(Map<String, dynamic> json) =>
      _$EmailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$EmailsDataToJson(this);
}

extension EmailParser on String {
  ({String? name, String? company}) parse(String separator) {
    final parts = split(separator);
    if (parts.length == 2) {
      final companyName = parts[1].split('.').first;
      return (name: parts[0], company: companyName);
    }
    return (name: null, company: null);
  }
}
