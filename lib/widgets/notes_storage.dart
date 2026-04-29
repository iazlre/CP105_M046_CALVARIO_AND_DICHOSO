import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// Stores notes as a list of maps:
///   - title: String
///   - contentDelta: String (JSON‑encoded Delta from flutter_quill)
class NotesStorage {
  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/notes.json');
  }

  Future<void> saveNotes(List<Map<String, String>> notes) async {
    final file = await _getFile();
    await file.writeAsString(jsonEncode(notes));
  }

  Future<List<Map<String, String>>> loadNotes() async {
    try {
      final file = await _getFile();
      final contents = await file.readAsString();
      final List<dynamic> decoded = jsonDecode(contents);
      return decoded.map((item) => Map<String, String>.from(item)).toList();
    } catch (e) {
      return [];
    }
  }
}