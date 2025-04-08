part of 'emails_extractor_bloc.dart';

sealed class EmailsExtractorEvent {}

final class EmailsExtractorTextChanged extends EmailsExtractorEvent {
  final String inputText;

  EmailsExtractorTextChanged({required this.inputText});
}
