import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwordies/stopwordies.dart';

part 'word_counter_state.dart';

class WordCounterCubit extends Cubit<WordCounterState> {
  WordCounterCubit() : super(WordCounterInitial());

  Future<void> countWords(String text) async {
    final stopWords = await StopWordies.getFor(locale: SWLocale.en);

    final wordRegExp = RegExp(r"\b\w+(?:'\w+)?\b");
    final wordsMap = wordRegExp
        .allMatches(text)
        .map((match) => match.group(0)!)
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

    emit(WordCounterLoaded(wordsPercentage));
  }
}
