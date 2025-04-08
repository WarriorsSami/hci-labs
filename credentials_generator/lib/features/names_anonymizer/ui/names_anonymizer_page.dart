import 'package:credentials_generator/features/names_anonymizer/bloc/names_anonymizer_bloc.dart'
    show
        NamesAnonymizerBloc,
        NamesAnonymizerLoadSuccess,
        NamesAnonymizerState,
        NamesAnonymizerTextChanged;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NamesAnonymizerPage extends StatelessWidget {
  final TextEditingController anonymizedTextController =
      TextEditingController();

  NamesAnonymizerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        BlocListener<NamesAnonymizerBloc, NamesAnonymizerState>(
          listener: (context, state) {
            if (state is NamesAnonymizerLoadSuccess) {
              anonymizedTextController.text =
                  state.sensitiveText.anonymizedText;
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
                    context.read<NamesAnonymizerBloc>().add(
                      NamesAnonymizerTextChanged(inputText: text),
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
                  readOnly: true,
                  controller: anonymizedTextController,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
