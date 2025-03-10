import 'dart:collection';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwordies/stopwordies.dart';

part 'word_counter_state.dart';

class WordCounterCubit extends Cubit<WordCounterState> {
  WordCounterCubit() : super(WordCounterInitial());

  Future<HashMap<String, double>> _countWords(String text) async {
    final stopWords = await StopWordies.getFor(locale: SWLocale.en);

    final wordRegExp = RegExp(r"\b\w+(?:'\w+)?\b");
    final wordsMap = wordRegExp
        .allMatches(text)
        .map((match) => match.group(0)!.toLowerCase())
        .where((word) => word.isNotEmpty && !stopWords.contains(word))
        .fold<HashMap<String, int>>(HashMap(), (map, word) {
          map.update(
            word.toLowerCase(),
            (value) => value + 1,
            ifAbsent: () => 1,
          );
          return map;
        });

    final wordsCount = wordsMap.entries.fold<int>(
      0,
      (count, entry) => count + entry.value,
    );
    final wordsPercentage = wordsMap.entries.fold<HashMap<String, double>>(
      HashMap(),
      (map, entry) {
        map[entry.key] = double.parse(
          (entry.value / wordsCount * 100).toStringAsFixed(1),
        );
        return map;
      },
    );

    return wordsPercentage;
  }

  Future<void> countWordsForInputText(String text) async {
    emit(
      WordCounterLoadedForInputText(
        text: text,
        wordCount: await _countWords(text),
      ),
    );
  }

  Future<void> countWordsForTextFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = File(result.files.single.path!);
      final text = await file.readAsString();
      emit(
        WordCounterLoadedForTextFile(
          text: text,
          wordCount: await _countWords(text),
        ),
      );
    }
  }
}
