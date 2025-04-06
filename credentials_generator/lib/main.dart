import 'package:credentials_generator/features/names_anonymizer/bloc/names_anonymizer_cubit.dart';
import 'package:credentials_generator/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const CredentialsGeneratorApp());
}

class CredentialsGeneratorApp extends StatelessWidget {
  const CredentialsGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credentials Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        cardTheme: CardTheme(
          color: Colors.blueGrey[200],
          shadowColor: Colors.black,
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black, size: 50),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 20, color: Colors.black),
          displayMedium: TextStyle(fontSize: 16, color: Colors.black),
          displaySmall: TextStyle(fontSize: 12, color: Colors.black),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          secondary: Colors.red,
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<NamesAnonymizerCubit>(
            create: (context) => NamesAnonymizerCubit(),
          ),
        ],
        child: const HomeLayout(),
      ),
    );
  }
}
