import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  final String text;
  const MyTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
        fontSize: 30,
        color: Color.fromARGB(255, 80, 80, 80),
      ),
    );
  }
}
