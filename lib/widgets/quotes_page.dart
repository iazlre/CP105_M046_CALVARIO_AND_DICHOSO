import 'package:flutter/material.dart';
import 'quotes_category_page.dart';

/// Quotes page widget displaying quote categories in a grid layout.
/// 
/// Shows six quote categories (School, Love, Food, Life, Family, Self)
/// with associated icons. Each category card navigates to [QuoteCategoryPage]
/// for browsing quotes within that category.
class QuotesPage extends StatelessWidget {
  const QuotesPage({super.key});

  /// Builds a grid view of quote category cards.
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
      body: Center(
        // This Center widget centers the grid inside the page.
        // If you remove Center, the grid will expand to fill the available space.
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30,
            top: 0,
            right: 30,
            bottom: 60,
          ),
          // When you change the padding values above, only the spacing
          // around the grid changes, not the size of the cards themselves.
          child: GridView(
            // shrinkWrap makes the GridView size itself to its content
            // instead of expanding to infinite height inside Center.
            shrinkWrap: true,
            // Disable scrolling so the grid stays centered and does not scroll.
            // Remove or change this if you want scrolling behavior.
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // number of columns in the grid
              crossAxisSpacing: 20, // horizontal space between cards
              mainAxisSpacing: 20, // vertical space between cards
              mainAxisExtent: 150, // height of each row in the grid
            ),
            children: [
              _buildCategoryCard(context, "School", Icons.school),
              _buildCategoryCard(context, "Love", Icons.favorite),
              _buildCategoryCard(context, "Food", Icons.restaurant),
              _buildCategoryCard(context, "Life", Icons.wb_sunny),
              _buildCategoryCard(context, "Family", Icons.family_restroom),
              _buildCategoryCard(context, "Self", Icons.person),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds an individual category card with icon and title.
  /// 
  /// Parameters:
  ///   - [context]: The build context for navigation
  ///   - [title]: The category title to display
  ///   - [icon]: The icon to display for the category
  /// 
  /// Returns a card that navigates to [QuoteCategoryPage] when tapped.
  Widget _buildCategoryCard(BuildContext context, String title, IconData icon) {
    return SizedBox(
      // Set the height of each card here. If you also want to control
      // the card width, add width: 140 or another value.
      height: 150,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => QuoteCategoryPage(title: title),
              ),
            );
          },
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // The icon shown at the top of the card.
                Icon(icon, size: 20, color: Theme.of(context).primaryColor),
                const SizedBox(height: 0),
                // The category title text shown below the icon.
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
