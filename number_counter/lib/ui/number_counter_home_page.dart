import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:number_counter/bloc/number_counter_cubit.dart';
import 'package:number_counter/ui/bar_chart_widget.dart';
import 'package:number_counter/ui/pie_chart_widget.dart';

class NumberCounterHomePage extends StatelessWidget {
  final _debouncer = Debouncer();

  NumberCounterHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Counter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocBuilder<NumberCounterCubit, NumberCounterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 100, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 20),
                if (state is NumberCounterInitial)
                  const Text(
                    'Enter some text to count the numbers',
                    style: TextStyle(fontSize: 20),
                  ),
                if (state is NumberCounterLoadedState)
                  state.numberCount.isNotEmpty
                      ? Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: BarChartWidget(
                                wordCount: state.numberCount,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Column(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: PieChartWidget(
                                      wordCount: state.numberCount,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Min: ${state.min}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Text(
                                          'Max: ${state.max}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Text(
                                          'Sum: ${state.sum}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                      : const Text(
                        'Enter some text to count the numbers',
                        style: TextStyle(fontSize: 20),
                      ),
                SizedBox(height: 20),
                TextField(
                  controller:
                      state is NumberCounterLoadedForTextFile
                          ? TextEditingController(text: state.text)
                          : null,
                  decoration: const InputDecoration(labelText: 'Text to count'),
                  maxLines: null,
                  onChanged: (text) {
                    const duration = Duration(milliseconds: 500);
                    _debouncer.debounce(
                      duration: duration,
                      onDebounce: () async {
                        await context
                            .read<NumberCounterCubit>()
                            .countNumbersForInputText(text);
                      },
                    );
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.read<NumberCounterCubit>().countNumbersForTextFile();
        },
        child: const Icon(Icons.upload),
      ),
    );
  }
}
