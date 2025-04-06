import 'package:flutter/material.dart';

class EmailsExtractorPage extends StatelessWidget {
  const EmailsExtractorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardTheme.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Emails Extractor"),
          const SizedBox(height: 20),
          const Row(),
        ],
      ),
    );
  }
}
