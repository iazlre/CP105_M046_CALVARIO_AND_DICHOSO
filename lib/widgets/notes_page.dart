import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:dart_quill_delta/dart_quill_delta.dart';  // For Delta class
import 'note_creation_page.dart';
import 'notes_storage.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Map<String, String>> _notes = [];
  final NotesStorage _storage = NotesStorage();

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await _storage.loadNotes();
    setState(() => _notes = notes);
  }

  Future<void> _saveNotes(List<Map<String, String>> notes) async {
    await _storage.saveNotes(notes);
    setState(() => _notes = notes);
  }

  Future<void> _createNote() async {
    final newNote = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (_) => const NoteCreationPage()),
    );
    if (newNote != null && newNote['title']!.trim().isNotEmpty) {
      await _saveNotes([..._notes, newNote]);
    }
  }

  Future<void> _editNote(int index) async {
    final editedNote = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => NoteCreationPage(existingNoteData: _notes[index]),
      ),
    );
    if (editedNote != null && editedNote['title']!.trim().isNotEmpty) {
      final updated = List<Map<String, String>>.from(_notes);
      updated[index] = editedNote;
      await _saveNotes(updated);
    }
  }

  Future<void> _deleteNote(int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete note'),
        content: const Text('Are you sure?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
        ],
      ),
    );
    if (confirm == true) {
      final updated = List<Map<String, String>>.from(_notes);
      updated.removeAt(index);
      await _saveNotes(updated);
    }
  }

  /// Extracts plain text from a Quill Delta JSON string for preview
  String _getPlainTextPreview(String deltaJson) {
    try {
      final deltaObj = Delta.fromJson(jsonDecode(deltaJson));
      return quill.Document.fromDelta(deltaObj).toPlainText().trim();
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes")),
      body: _notes.isEmpty
          ? const Center(
              child: Text('No notes yet.\nTap + to create one.',
                  textAlign: TextAlign.center),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  mainAxisExtent: 150,
                ),
                itemCount: _notes.length,
                itemBuilder: (ctx, index) {
                  final note = _notes[index];
                  final title = note['title']!;
                  final preview = _getPlainTextPreview(note['contentDelta'] ?? '{}');
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: InkWell(
                      onTap: () => _editNote(index),
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Expanded(
                              child: Text(
                                preview.isEmpty ? 'No content' : preview,
                                style: const TextStyle(fontSize: 12),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red, size: 18),
                                onPressed: () => _deleteNote(index),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}