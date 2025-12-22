import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/note.dart';
import 'package:flutter_application_1/pages/notepad/note_editor_page.dart';
import 'package:flutter_application_1/providers/note_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class NotepadPage extends ConsumerWidget {
  const NotepadPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(noteProvider);

    // debugPrint('🧱 UI rebuild, notes = ${notes.length}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notepad'),
      ),

      // 🔴 INI BAGIAN PENTING
      body: Column(
        children: [
          // (optional) header / search / dll
          const SizedBox(height: 8),

          // ✅ ListView HARUS dibungkus Expanded
          Expanded(
            child: notes.isEmpty
                ? const Center(
                    child: Text(
                      'Belum ada catatan',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final Note note = notes[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: ListTile(
                           title: Text(
    note.title,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  ),
  subtitle: Text(
    note.content,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  ),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NoteEditorPage(note: note),
      ),
    );
  },
),
                      );
                    },
                  ),
          ),
        ],
      ),

      // ➕ BUTTON ADD NOTE
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNoteDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  // ==============================
  // ADD NOTE DIALOG
  // ==============================
  void _showAddNoteDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Tambah Catatan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: 'Isi',
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
  final title = titleController.text.trim();
  final content = contentController.text.trim();

  if (title.isEmpty || content.isEmpty) return;

  final note = Note(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    title: title,
    content: content,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  ref.read(noteProvider.notifier).addNote(note);

  Navigator.pop(context);
},

              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }
}
