import 'package:flutter/material.dart';

class PasswordsGeneratorPage extends StatelessWidget {
  const PasswordsGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardTheme.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Passwords Generator"),
          const SizedBox(height: 20),
          const Row(),
        ],
      ),
    );
  }
}
