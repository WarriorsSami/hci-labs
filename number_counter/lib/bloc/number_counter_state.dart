part of 'number_counter_cubit.dart';

sealed class NumberCounterState {}

final class NumberCounterInitial extends NumberCounterState {}

sealed class NumberCounterLoadedState extends NumberCounterState {
  int get min;
  int get max;
  int get sum;
  HashMap<String, double> get numberCount;
}

final class NumberCounterLoadedForInputText extends NumberCounterLoadedState {
  final String text;

  @override
  final int min;

  @override
  final int max;

  @override
  final int sum;

  @override
  final HashMap<String, double> numberCount;

  NumberCounterLoadedForInputText({
    required this.text,
    required this.min,
    required this.max,
    required this.sum,
    required this.numberCount,
  });
}

final class NumberCounterLoadedForTextFile extends NumberCounterLoadedState {
  final String text;

  @override
  final int min;

  @override
  final int max;

  @override
  final int sum;

  @override
  final HashMap<String, double> numberCount;

  NumberCounterLoadedForTextFile({
    required this.text,
    required this.min,
    required this.max,
    required this.sum,
    required this.numberCount,
  });
}
