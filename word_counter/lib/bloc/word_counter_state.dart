part of 'word_counter_cubit.dart';

sealed class WordCounterState {}

final class WordCounterInitial extends WordCounterState {}

final class WordCounterLoaded extends WordCounterState {
  final String text;
  final HashMap<String, double> wordCount;

  WordCounterLoaded({required this.text, required this.wordCount});
}
