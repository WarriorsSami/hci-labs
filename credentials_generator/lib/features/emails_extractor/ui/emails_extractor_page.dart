import 'package:credentials_generator/features/emails_extractor/bloc/emails_extractor_bloc.dart';
import 'package:credentials_generator/features/emails_extractor/models/emails_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailsExtractorPage extends StatelessWidget {
  const EmailsExtractorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.email),
            SizedBox(width: 10),
            Text(
              "Emails Extractor",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 4,
              child: TextField(
                maxLines: 10,
                decoration: InputDecoration(
                  labelText: "Input Text",
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  context.read<EmailsExtractorBloc>().add(
                    EmailsExtractorTextChanged(inputText: text),
                  );
                },
              ),
            ),
            Flexible(child: SizedBox(width: 40)),
            Flexible(
              flex: 4,
              child: BlocBuilder<EmailsExtractorBloc, EmailsExtractorState>(
                builder: (context, state) {
                  if (state is EmailsExtractorLoadSuccess) {
                    return state.emailsData.emails.isEmpty
                        ? Text(
                          "No emails extracted yet",
                          style: TextStyle(color: Colors.grey[600]),
                        )
                        : Table(
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(1),
                            2: FlexColumnWidth(1),
                          },
                          border: TableBorder.all(color: Colors.grey),
                          children: [
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Username",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Company Name",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ...state.emailsData.emails.map((emailData) {
                              final (:name, :company) = emailData.parse('@');

                              return TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(emailData),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(name!),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(company!),
                                  ),
                                ],
                              );
                            }),
                          ],
                        );
                  }
                  return Text(
                    "No emails extracted yet",
                    style: TextStyle(color: Colors.grey[600]),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
