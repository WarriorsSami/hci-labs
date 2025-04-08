import 'package:credentials_generator/features/emails_extractor/models/emails_data.dart';
import 'package:credentials_generator/features/shared/logic/transformers.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'emails_extractor_event.dart';
part 'emails_extractor_state.dart';

class EmailsExtractorBloc
    extends Bloc<EmailsExtractorEvent, EmailsExtractorState>
    with HydratedMixin<EmailsExtractorState> {
  EmailsExtractorBloc() : super(EmailsExtractorInitial()) {
    hydrate();
    on<EmailsExtractorTextChanged>(
      _onTextChanged,
      transformer: debounce(const Duration(milliseconds: 300)),
    );
  }

  void _onTextChanged(
    EmailsExtractorTextChanged event,
    Emitter<EmailsExtractorState> emit,
  ) {
    final emailsData = EmailsData.fromText(event.inputText);
    emit(EmailsExtractorLoadSuccess(emailsData: emailsData));
  }

  @override
  EmailsExtractorState? fromJson(Map<String, dynamic> json) {
    try {
      return EmailsExtractorLoadSuccess(emailsData: EmailsData.fromJson(json));
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(EmailsExtractorState state) {
    if (state is EmailsExtractorLoadSuccess) {
      return state.emailsData.toJson();
    }
    return null;
  }
}
