import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Settings page widget for application configuration.
///
/// This page is designed to match the provided design with clearly
/// separated cards for About, Help, Suggestions, and Themes.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  /// Open a website link in the default browser.
  ///
  /// This uses `LaunchMode.externalApplication` so the link opens outside
  /// the app, which works better for most web URLs.
  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
      // Optionally show a snackbar or dialog to user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          // Top header button-style label matching the screenshot.
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const _SettingsSection(
            title: 'About',
            child: Text(
              'The MotiNotes App is an interactive mobile app designed to help students stay motivated and organized in their academic activities.',
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
          const SizedBox(height: 14),
          _SettingsSection(
            title: 'Help',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Clickable name link
                GestureDetector(
                  onTap: () => _openLink('https://www.facebook.com/raizelcalvari0/'),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Raizel Teresse G. Calvario',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _openLink('https://www.facebook.com/dichoso.jam'),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Jamila Armie P. Dichoso',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => _openLink('https://facebook.com'),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.facebook, color: Colors.blue, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Facebook',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _SettingsSection(
            title: 'Suggestions',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'What suggestions do you have to improve MotiNotes?',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _openLink('https://sites.google.com/view/motinotesfreedomwall/home'),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Click Freedom Wall',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _SettingsSection(
            title: 'Themes',
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: GestureDetector(
                  onTap: () {
                    // Add theme switching logic here
                    // Example: Toggle between light and dark theme
                  },
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.nights_stay, size: 28, color: Colors.black87),
                      SizedBox(height: 10),
                      Text(
                        'Night',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Reusable card section used by the settings page.
///
/// Displays a title and a child widget inside a rounded card with padding.
class _SettingsSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _SettingsSection({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}