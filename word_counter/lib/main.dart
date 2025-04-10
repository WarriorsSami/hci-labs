import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_counter/bloc/word_counter_cubit.dart';
import 'package:word_counter/ui/word_counter_home_page.dart';

void main() {
  runApp(const WordCounterApp());
}

class WordCounterApp extends StatelessWidget {
  const WordCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: BlocProvider(
        create: (_) => WordCounterCubit(),
        child: WordCounterHomePage(),
      ),
    );
  }
}
