import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String text;

  const Header({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return (
        Container(
          margin: const EdgeInsets.only(bottom: 10.0, top: 0.5),
          child: Text(text, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        )
    );
  }
}
