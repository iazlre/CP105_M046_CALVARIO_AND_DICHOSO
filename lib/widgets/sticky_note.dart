import 'package:flutter/material.dart';

class StickyNote extends StatelessWidget {
  final String text;

  const StickyNote({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        height: 250,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}