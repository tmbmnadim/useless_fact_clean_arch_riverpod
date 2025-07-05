import 'package:flutter/material.dart';

class UselessFactCard extends StatelessWidget {
  final String text;

  const UselessFactCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: SizedBox(
        width: screen.width,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
