part of 'names_anonymizer_bloc.dart';

sealed class NamesAnonymizerEvent {}

final class NamesAnonymizerTextChanged extends NamesAnonymizerEvent {
  final String inputText;

  NamesAnonymizerTextChanged({required this.inputText});
}
