import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:word_counter/bloc/word_counter_cubit.dart';

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
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state is WordCounterInitial)
                    const Text('Enter some text to count the words'),
                  if (state is WordCounterLoaded)
                    Text('Word count: ${state.wordCount.length}'),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Enter some text',
                    ),
                    maxLines: null,
                    onChanged: (text) {
                      const duration = Duration(milliseconds: 500);
                      _debouncer.debounce(
                        duration: duration,
                        onDebounce: () async {
                          await context.read<WordCounterCubit>().countWords(
                            text,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
