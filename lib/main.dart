import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Entry point of the MotiNotes application.
/// Initializes and runs the root [MyApp] widget.
void main() {
  runApp(const MyApp());
}

/// Root widget of the MotiNotes application.
/// 
/// Configures the Material app with theme settings including:
/// - App title: 'MotiNotes'
/// - Color scheme based on deep purple seed color
/// - Material Design 3 styling
/// - Home page: [HomePage]
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// Builds the Material application with configured theme and home page.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MotiNotes',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FlutterQuillLocalizations.delegate,  // Add Flutter Quill localization
      ],

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
