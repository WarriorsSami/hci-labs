part of 'emails_extractor_bloc.dart';

sealed class EmailsExtractorState {}

final class EmailsExtractorInitial extends EmailsExtractorState {}

final class EmailsExtractorLoadSuccess extends EmailsExtractorState {
  final EmailsData emailsData;

  EmailsExtractorLoadSuccess({required this.emailsData});
}
