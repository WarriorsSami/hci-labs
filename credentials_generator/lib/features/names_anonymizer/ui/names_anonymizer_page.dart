import 'package:credentials_generator/features/names_anonymizer/bloc/names_anonymizer_cubit.dart'
    show NamesAnonymizerCubit, NamesAnonymizerLoadedState, NamesAnonymizerState;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NamesAnonymizerPage extends StatelessWidget {
  final TextEditingController anonymizedTextController =
      TextEditingController();

  NamesAnonymizerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardTheme.color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person),
                SizedBox(width: 10),
                Text(
                  "Anonymize Names",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
            SizedBox(height: 20),
            BlocListener<NamesAnonymizerCubit, NamesAnonymizerState>(
              listener: (context, state) {
                if (state is NamesAnonymizerLoadedState) {
                  anonymizedTextController.text = state.anonymizedText;
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: TextField(
                      maxLines: 10,
                      decoration: InputDecoration(
                        labelText: "Input Names",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (text) {
                        context.read<NamesAnonymizerCubit>().anonymizeNames(
                          text,
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 40),
                  Flexible(
                    child: TextFormField(
                      maxLines: 10,
                      decoration: InputDecoration(
                        labelText: "Anonymized Names",
                        border: OutlineInputBorder(),
                      ),
                      controller: anonymizedTextController,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
