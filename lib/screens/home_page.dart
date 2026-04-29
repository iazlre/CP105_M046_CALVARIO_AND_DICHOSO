// Import Flutter's material design library for UI components
import 'package:flutter/material.dart';
// Import the quotes page widget for navigation
import '../widgets/quotes_page.dart';
// Import the notes page widget for navigation
import '../widgets/notes_page.dart';
// Import the settings page widget for navigation
import '../widgets/settings_page.dart';

/// Main home page widget of the MotiNotes application.
/// 
/// Displays the primary dashboard with:
/// - Custom app bar with title and settings button
/// - Quote of the day section
/// - Explore section with navigation cards for Quotes and Notes
/// - Motivation section
/// 
/// Provides navigation to [QuotesPage], [NotesPage], and [SettingsPage].
/// 
/// To customize:
/// - Change app title in the AppBar
/// - Modify section headers in _SectionHeader widgets
/// - Update placeholder text in FeatureCard widgets
/// - Adjust colors using Theme.of(context).colorScheme
/// - Add new sections by adding more children to the Column
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /// Builds the home page scaffold with app bar and scrollable body content.
  /// 
  /// This method creates the main layout structure:
  /// - Scaffold provides the basic app structure
  /// - AppBar contains the title and settings icon
  /// - SingleChildScrollView allows scrolling for content
  /// - Column arranges sections vertically
  @override
  Widget build(BuildContext context) {
    // Get theme data for consistent styling
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      // Custom app bar with increased height and transparent background
      appBar: AppBar(
        toolbarHeight: 120, // Change this value to adjust app bar height
        backgroundColor: Colors.transparent, // Change to a color if needed
        elevation: 0, // Set to a number > 0 for shadow effect
        title: Padding(
          padding: const EdgeInsets.only(top: 40), // Adjust padding as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "MotiNotes", // Change this to your app name
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface, // Change color if needed
                ),
              ),
              Text(
                "Inspire. Reflect. Grow.", // Change this tagline
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant, // Change color if needed
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined), // Change icon if needed
            onPressed: () => _navigateTo(context, const SettingsPage()), // Navigates to settings page
          ),
          const SizedBox(width: 16), // Adjust spacing as needed
        ],
      ),
      // Scrollable body with padding
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0), // Adjust padding for margins
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quote of the day section header
            const _SectionHeader(title: "QUOTE OF THE DAY"), // Change section title here
            // Placeholder for daily quote - replace with actual quote widget
            const FeatureCard(
              height: 130, // Adjust card height
              label: "\"God put that dream in your heart for a reason.\"\n\n - Unknown", // Replace with actual quote text or widget
            ),
            const SizedBox(height: 32), // Spacing between sections
            // Explore section header
            const _SectionHeader(title: "EXPLORE"), // Change section title here
            // Row with navigation cards for Quotes and Notes
            Row(
              children: [
                Expanded(
                  child: FeatureCard(
                    height: 120, // Adjust card height
                    label: "QUOTES", // Change button text
                    onTap: () => _navigateTo(context, const QuotesPage()), // Navigates to quotes page
                  ),
                ),
                const SizedBox(width: 16), // Spacing between cards
                Expanded(
                  child: FeatureCard(
                    height: 120, // Adjust card height
                    label: "NOTES", // Change button text
                    onTap: () => _navigateTo(context, const NotesPage()), // Navigates to notes page
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32), // Spacing between sections
            // Motivation section header
            const _SectionHeader(title: "MOTIVATION"), // Change section title here
            // Motivation card with icon
            FeatureCard(
              height: 110, // Adjust card height
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    // Lightning bolt icon
                    Icon(
                      Icons.flash_on,
                      size: 32,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 16),
                    // Motivation text
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Keep going!',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSecondaryContainer,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Every day is a new chance to grow.',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSecondaryContainer,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Navigates to a new page by pushing it onto the navigation stack.
  /// 
  /// Parameters:
  ///   - [context]: The build context used for navigation
  ///   - [page]: The widget page to navigate to
  /// 
  /// To change navigation behavior:
  /// - Use Navigator.pushReplacement for replacing current page
  /// - Use Navigator.pushNamed for named routes
  /// - Add custom transitions with PageRouteBuilder
  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

/// Section header widget for organizing content sections.
/// 
/// Displays a styled text header with bold font, increased letter spacing,
/// and primary color scheme.
/// 
/// To customize:
/// - Change font weight, size, or color in the TextStyle
/// - Adjust padding in the Padding widget
/// - Modify letter spacing for different visual effects
class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  /// Builds a formatted section header text.
  /// 
  /// Uses theme colors for consistency with app design.
  /// Adjust styling properties here to change appearance.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8), // Adjust spacing around header
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold, // Change to normal for less emphasis
              letterSpacing: 1.5, // Adjust letter spacing (0 for normal)
              color: Theme.of(context).colorScheme.primary, // Change color as needed
            ),
      ),
    );
  }
}

/// Reusable feature card widget for displaying interactive content blocks.
/// 
/// Displays a card with customizable height and label text. Includes
/// tap callback support for navigation or user interaction.
/// 
/// Properties:
///   - [height]: The vertical dimension of the card
///   - [label]: The text label displayed on the card
///   - [onTap]: Optional callback function when card is tapped
/// 
/// To customize:
/// - Change card color by modifying colorScheme.secondaryContainer
/// - Adjust border radius in RoundedRectangleBorder
/// - Add icons or images by replacing the Text child
/// - Modify elevation for shadow effects
/// - Change text styling in the Text widget
class FeatureCard extends StatelessWidget {
  final double height;
  final String? label;
  final Widget? child;
  final VoidCallback? onTap;

  const FeatureCard({
    super.key,
    required this.height,
    this.label,
    this.child,
    this.onTap,
  }) : assert(label != null || child != null, 'Provide either label or child');

  /// Builds a styled card with optional tap interaction.
  /// 
  /// Uses Material Design Card with InkWell for ripple effect on tap.
  /// Card is fully interactive if onTap is provided.
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0, // Set to 4-8 for shadow, 0 for flat design
      color: colorScheme.secondaryContainer, // Change card background color
      clipBehavior: Clip.antiAlias, // Prevents ripple from going outside rounded corners
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), // Adjust corner radius
      child: InkWell(
        onTap: onTap, // Add tap functionality - null means no interaction
        child: Container(
          height: height, // Card height - adjust as needed
          width: double.infinity, // Full width
          alignment: Alignment.center, // Center the content
          child: child ?? Text(
            label!, // The text displayed on the card
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 13, // Custom font size in pixels (default titleMedium is ~16px)
                  fontWeight: FontWeight.bold, // Change to normal for regular weight
                  color: colorScheme.onSecondaryContainer, // Text color on card
                ),
          ),
        ),
      ),
    );
  }
}
