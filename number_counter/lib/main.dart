import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_counter/bloc/number_counter_cubit.dart';
import 'package:number_counter/ui/number_counter_home_page.dart';

void main() {
  runApp(const WordCounterApp());
}

class WordCounterApp extends StatelessWidget {
  const WordCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: BlocProvider(
        create: (_) => NumberCounterCubit(),
        child: NumberCounterHomePage(),
      ),
    );
  }
}
