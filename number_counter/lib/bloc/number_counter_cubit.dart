import 'dart:collection';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'number_counter_state.dart';

typedef NumbersMetadata =
    ({int min, int max, int sum, HashMap<String, double> numberCount});

class NumberCounterCubit extends Cubit<NumberCounterState> {
  NumberCounterCubit() : super(NumberCounterInitial());

  Future<NumbersMetadata> _countNumbers(String text) async {
    final parts = text.split(RegExp(r'\D+'));

    final numbers =
        parts
            .where((part) => part.isNotEmpty)
            .map((part) => part.toLowerCase())
            .map((part) => int.parse(part))
            .toList();

    final min = numbers.reduce(
      (value, element) => value < element ? value : element,
    );
    final max = numbers.reduce(
      (value, element) => value > element ? value : element,
    );
    final sum = numbers.reduce((value, element) => value + element);

    final numbersMap = parts
        .where((part) => part.isNotEmpty)
        .toList()
        .fold<HashMap<String, int>>(HashMap(), (map, number) {
          map.update(
            number.toLowerCase(),
            (value) => value + 1,
            ifAbsent: () => 1,
          );
          return map;
        });

    final numbersCount = numbersMap.entries.fold<int>(
      0,
      (count, entry) => count + entry.value,
    );
    final numbersPercentage = numbersMap.entries.fold<HashMap<String, double>>(
      HashMap(),
      (map, entry) {
        map[entry.key] = double.parse(
          (entry.value / numbersCount * 100).toStringAsFixed(1),
        );
        return map;
      },
    );

    return (min: min, max: max, sum: sum, numberCount: numbersPercentage);
  }

  Future<void> countNumbersForInputText(String text) async {
    final numbersMetadata = await _countNumbers(text);

    emit(
      NumberCounterLoadedForInputText(
        text: text,
        min: numbersMetadata.min,
        max: numbersMetadata.max,
        sum: numbersMetadata.sum,
        numberCount: numbersMetadata.numberCount,
      ),
    );
  }

  Future<void> countNumbersForTextFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = File(result.files.single.path!);
      final text = await file.readAsString();
      final numbersMetadata = await _countNumbers(text);

      emit(
        NumberCounterLoadedForTextFile(
          text: text,
          min: numbersMetadata.min,
          max: numbersMetadata.max,
          sum: numbersMetadata.sum,
          numberCount: numbersMetadata.numberCount,
        ),
      );
    }
  }
}
