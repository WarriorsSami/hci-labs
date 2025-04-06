import 'package:bloc/bloc.dart';

part 'names_anonymizer_state.dart';

// TODO: add a debounce transformer using bloc concurrency
// TODO: add caching using hydrated bloc
class NamesAnonymizerCubit extends Cubit<NamesAnonymizerState> {
  NamesAnonymizerCubit() : super(NamesAnonymizerInitialState());

  void anonymizeNames(String inputText) {
    // replace each word starting with an uppercase letter with as many "x" as the length of the word
    final anonymizedText = inputText
        .split(' ')
        .map(
          (word) => RegExp(r'^[A-Z]').hasMatch(word) ? 'x' * word.length : word,
        )
        .join(' ');

    print(anonymizedText);

    emit(
      NamesAnonymizerLoadedState(
        inputText: inputText,
        anonymizedText: anonymizedText,
      ),
    );
  }
}
