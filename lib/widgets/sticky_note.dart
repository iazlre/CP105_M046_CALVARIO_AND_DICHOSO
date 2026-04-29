import 'package:flutter/material.dart';

/// A sticky note widget for displaying text content.
/// 
/// Displays text centered within a fixed-size square container (250x250).
/// Used to present quotes and other text-based content in a card-like format.
/// 
/// Properties:
///   - [text]: The text content to display on the sticky note
class StickyNote extends StatelessWidget {
  final String text;

  const StickyNote({super.key, required this.text});

  /// Builds a centered container displaying the sticky note text.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250,
        height: 250,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}