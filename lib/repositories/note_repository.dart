import 'package:hive/hive.dart';

import '../models/note.dart';

class NoteRepository {
  static const _boxName = 'notesbox';

  Box get _box {
    final box = Hive.box(_boxName);
    // print('📦 Box opened: ${box.name}, length=${box.length}');
    return box;
  }

  List<Note> getAll() {
    final notes = _box.values
        .map((e) => Note.fromMap(Map<String, dynamic>.from(e)))
        .toList();

    // print('📖 getAll() -> ${notes.length} notes');
    return notes;
  }

  void add(Note note) {
    // print('➕ ADD NOTE: ${note.title}');
    _box.put(note.id, note.toMap());
    // print('📦 Box length after add: ${_box.length}');
  }

  void update(Note note) {
    // print('✏️ UPDATE NOTE: ${note.id}');
    _box.put(note.id, note.toMap());
  }

  void delete(String id) {
    // print('🗑 DELETE NOTE: $id');
    _box.delete(id);
  }
}
