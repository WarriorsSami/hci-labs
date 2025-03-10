import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:word_counter/bloc/word_counter_cubit.dart';
import 'package:word_counter/ui/bar_chart_widget.dart';
import 'package:word_counter/ui/pie_chart_widget.dart';

class WordCounterHomePage extends StatelessWidget {
  final _debouncer = Debouncer();

  WordCounterHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Counter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocBuilder<WordCounterCubit, WordCounterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 100, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 20),
                if (state is WordCounterInitial)
                  const Text(
                    'Enter some text to count the words',
                    style: TextStyle(fontSize: 20),
                  ),
                if (state is WordCounterLoadedState)
                  state.wordCount.isNotEmpty
                      ? Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: BarChartWidget(wordCount: state.wordCount),
                            ),
                            Flexible(
                              flex: 1,
                              child: PieChartWidget(wordCount: state.wordCount),
                            ),
                          ],
                        ),
                      )
                      : const Text(
                        'Enter some text to count the words',
                        style: TextStyle(fontSize: 20),
                      ),
                SizedBox(height: 20),
                TextField(
                  controller:
                      state is WordCounterLoadedForTextFile
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
                            .read<WordCounterCubit>()
                            .countWordsForInputText(text);
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
          await context.read<WordCounterCubit>().countWordsForTextFile();
        },
        child: const Icon(Icons.upload),
      ),
    );
  }
}
