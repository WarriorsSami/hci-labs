part of 'names_anonymizer_cubit.dart';

sealed class NamesAnonymizerState {}

final class NamesAnonymizerInitialState extends NamesAnonymizerState {}

final class NamesAnonymizerLoadedState extends NamesAnonymizerState {
  final String inputText;
  final String anonymizedText;

  NamesAnonymizerLoadedState({
    required this.inputText,
    required this.anonymizedText,
  });
}
