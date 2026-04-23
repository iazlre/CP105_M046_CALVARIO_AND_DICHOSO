import 'package:flutter/material.dart';
import '../widgets/quotes_page.dart';
import '../widgets/notes_page.dart';
import '../widgets/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "MotiNotes",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              Text(
                "Inspire. Reflect. Grow.",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => _navigateTo(context, const SettingsPage()),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeader(title: "QUOTE OF THE DAY"),
            const FeatureCard(
              height: 140,
              label: "Quote Placeholder",
            ),
            const SizedBox(height: 32),
            const _SectionHeader(title: "EXPLORE"),
            Row(
              children: [
                Expanded(
                  child: FeatureCard(
                    height: 120,
                    label: "QUOTES",
                    onTap: () => _navigateTo(context, const QuotesPage()),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FeatureCard(
                    height: 120,
                    label: "NOTES",
                    onTap: () => _navigateTo(context, const NotesPage()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const _SectionHeader(title: "MOTIVATION"),
            const FeatureCard(
              height: 140,
              label: "Motivation Placeholder",
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final double height;
  final String label;
  final VoidCallback? onTap;

  const FeatureCard({
    super.key,
    required this.height,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.secondaryContainer,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height,
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSecondaryContainer,
                ),
          ),
        ),
      ),
    );
  }
}
