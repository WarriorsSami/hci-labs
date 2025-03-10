part of 'word_counter_cubit.dart';

sealed class WordCounterState {}

final class WordCounterInitial extends WordCounterState {}

sealed class WordCounterLoadedState extends WordCounterState {
  HashMap<String, double> get wordCount;
}

final class WordCounterLoadedForInputText extends WordCounterLoadedState {
  final String text;
  @override
  final HashMap<String, double> wordCount;

  WordCounterLoadedForInputText({required this.text, required this.wordCount});
}

final class WordCounterLoadedForTextFile extends WordCounterLoadedState {
  final String text;
  @override
  final HashMap<String, double> wordCount;

  WordCounterLoadedForTextFile({required this.text, required this.wordCount});
}
