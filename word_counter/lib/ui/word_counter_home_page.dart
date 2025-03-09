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
            padding: const EdgeInsets.fromLTRB(16, 32, 128, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 20),
                if (state is WordCounterInitial)
                  const Text('Enter some text to count the words'),
                if (state is WordCounterLoaded)
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
                      : const Text('Enter some text to count the words'),
                TextField(
                  decoration: const InputDecoration(labelText: 'Text to count'),
                  maxLines: null,
                  onChanged: (text) {
                    const duration = Duration(milliseconds: 500);
                    _debouncer.debounce(
                      duration: duration,
                      onDebounce: () async {
                        await context.read<WordCounterCubit>().countWords(text);
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
        onPressed: () {},
        child: const Icon(Icons.upload),
      ),
    );
  }
}
