import 'package:flutter/material.dart';
import 'sticky_note.dart';

class QuoteCategoryPage extends StatelessWidget {
  final String title;

  const QuoteCategoryPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),

      body: PageView(
        children: const [
          StickyNote(text: "Quote 1"),
          StickyNote(text: "Quote 2"),
          StickyNote(text: "Quote 3"),
        ],
      ),
    );
  }
}