import 'package:flutter/material.dart';

class CardWrapper extends StatelessWidget {
  final Widget child;

  const CardWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardTheme.color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Tooltip(
              message: "Swipe to the left to see more",
              child: const Icon(
                Icons.arrow_circle_left_outlined,
                color: Colors.black12,
              ),
            ),
            Expanded(child: child),
            Tooltip(
              message: "Swipe to the right to see more",
              child: const Icon(
                Icons.arrow_circle_right_outlined,
                color: Colors.black12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
