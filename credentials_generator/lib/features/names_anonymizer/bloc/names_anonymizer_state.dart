part of 'names_anonymizer_bloc.dart';

sealed class NamesAnonymizerState {}

final class NamesAnonymizerInitial extends NamesAnonymizerState {}

final class NamesAnonymizerLoadSuccess extends NamesAnonymizerState {
  final SensitiveText sensitiveText;

  NamesAnonymizerLoadSuccess({required this.sensitiveText});
}
