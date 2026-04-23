import 'package:flutter/material.dart';
import 'quotes_category_page.dart';

class QuotesPage extends StatelessWidget {
  const QuotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quotes"),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _cat(context, "School"),
            _cat(context, "Love"),
            _cat(context, "Food"),
            _cat(context, "Life"),
            _cat(context, "Family"),
            _cat(context, "Self"),
          ],
        ),
      ),
    );
  }

  Widget _cat(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => QuoteCategoryPage(title: title),
          ),
        );
      },
      child: Container(
        width: 100,
        height: 50,
        child: Center(child: Text(title)),
      ),
    );
  }
}