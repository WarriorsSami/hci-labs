import 'package:credentials_generator/features/names_anonymizer/models/sensitive_text.dart';
import 'package:credentials_generator/features/shared/shared.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'names_anonymizer_event.dart';
part 'names_anonymizer_state.dart';

class NamesAnonymizerBloc
    extends Bloc<NamesAnonymizerEvent, NamesAnonymizerState>
    with HydratedMixin<NamesAnonymizerState> {
  NamesAnonymizerBloc() : super(NamesAnonymizerInitial()) {
    hydrate();
    on<NamesAnonymizerTextChanged>((event, emit) {
      _anonymizeNames(event.inputText, emit);
    }, transformer: debounce(const Duration(milliseconds: 300)));
  }

  void _anonymizeNames(String inputText, Emitter<NamesAnonymizerState> emit) {
    // replace each word starting with an uppercase letter with as many "x" as the length of the word
    final anonymizedText = inputText
        .split(' ')
        .map(
          (word) => RegExp(r'^[A-Z]').hasMatch(word) ? 'x' * word.length : word,
        )
        .join(' ');

    emit(
      NamesAnonymizerLoadSuccess(
        sensitiveText: SensitiveText(
          inputText: inputText,
          anonymizedText: anonymizedText,
        ),
      ),
    );
  }

  @override
  NamesAnonymizerState? fromJson(Map<String, dynamic> json) {
    try {
      return NamesAnonymizerLoadSuccess(
        sensitiveText: SensitiveText.fromJson(json),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(NamesAnonymizerState state) {
    if (state is NamesAnonymizerLoadSuccess) {
      return state.sensitiveText.toJson();
    }
    return null;
  }
}
