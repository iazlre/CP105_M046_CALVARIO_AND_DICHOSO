import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:dart_quill_delta/dart_quill_delta.dart';  // For Delta class

class NoteCreationPage extends StatefulWidget {
  final Map<String, String>? existingNoteData;

  const NoteCreationPage({super.key, this.existingNoteData});

  @override
  State<NoteCreationPage> createState() => _NoteCreationPageState();
}

class _NoteCreationPageState extends State<NoteCreationPage> {
  late final TextEditingController _titleController;
  late final quill.QuillController _quillController;
  bool _showToolbar = true;   // Track toolbar visibility

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.existingNoteData?['title'] ?? '',
    );

    final existingDelta = widget.existingNoteData?['contentDelta'];
    if (existingDelta != null && existingDelta.isNotEmpty) {
      try {
        final deltaJson = jsonDecode(existingDelta);
        final deltaObj = Delta.fromJson(deltaJson);
        final document = quill.Document.fromDelta(deltaObj);
        _quillController = quill.QuillController(
          document: document,
          selection: const TextSelection.collapsed(offset: 0),
        );
        _quillController.readOnly = false;
      } catch (e) {
        _quillController = quill.QuillController.basic();
        _quillController.readOnly = false;
      }
    } else {
      _quillController = quill.QuillController.basic();
      _quillController.readOnly = false;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _quillController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title')),
      );
      return;
    }

    final delta = _quillController.document.toDelta();
    final deltaJson = jsonEncode(delta.toJson());

    Navigator.pop(context, {
      'title': title,
      'contentDelta': deltaJson,
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingNoteData != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit note' : 'New note'),
        actions: [
          TextButton(onPressed: _saveNote, child: const Text('Save')),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: UnderlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          // Dropdown-style button to show/hide toolbar
          InkWell(
            onTap: () {
              setState(() {
                _showToolbar = !_showToolbar;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Formatting options',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _showToolbar ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
          // Toolbar and divider shown conditionally
          if (_showToolbar) ...[
            quill.QuillSimpleToolbar(
              controller: _quillController,
              config: const quill.QuillSimpleToolbarConfig(
                toolbarSize: 30,
                multiRowsDisplay: false,
                color: Color.fromARGB(255, 250, 220, 255),
              ),
            ),
            const Divider(height: 0, thickness: 1),
          ],
          Expanded(
            child: quill.QuillEditor.basic(
              controller: _quillController,
              config: const quill.QuillEditorConfig(
                autoFocus: true,
                expands: true,
                padding: EdgeInsets.all(16),
                scrollable: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}