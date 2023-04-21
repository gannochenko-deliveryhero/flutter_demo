import 'package:flutter/material.dart';

class Paragraph extends StatelessWidget {
  final String text;

  const Paragraph({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return (
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Text(text, style: const TextStyle(fontSize: 25)),
        )
    );
  }
}
