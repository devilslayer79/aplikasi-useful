import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/note.dart';
import 'package:flutter_application_1/providers/note_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class NoteEditorPage extends ConsumerStatefulWidget {
  final Note? note;

  const NoteEditorPage({super.key, this.note});

  @override
  ConsumerState<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends ConsumerState<NoteEditorPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();

    _titleController =
        TextEditingController(text: widget.note?.title ?? '');
    _contentController =
        TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _save() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) return;

    if (widget.note == null) {
      // CREATE
      final newNote = Note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        content: content,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      ref.read(noteProvider.notifier).addNote(newNote);
    } else {
      // EDIT
      final updatedNote = widget.note!.copyWith(
        title: title,
        content: content,
        updatedAt: DateTime.now(),
      );

      ref.read(noteProvider.notifier).updateNote(updatedNote);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.note != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Note' : 'Tambah Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _save,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Judul',
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Isi',
                  alignLabelWithHint: true,
                ),
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
