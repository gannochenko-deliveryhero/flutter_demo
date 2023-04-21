import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String text;

  const ListItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return (
        Text("👉 $text", style: const TextStyle(fontSize: 20))
    );
  }
}
