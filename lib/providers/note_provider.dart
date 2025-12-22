import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/note.dart';
import '../repositories/note_repository.dart';

/// ===============================
/// SORT TYPE (HARUS ENUM)
/// ===============================
enum NoteSortType {
  createdAt,
  updatedAt,
  custom,
}

/// ===============================
/// PROVIDER
/// ===============================
final noteProvider =
    NotifierProvider<NoteNotifier, List<Note>>(NoteNotifier.new);

class NoteNotifier extends Notifier<List<Note>> {
  late final NoteRepository _repository;

  NoteSortType _sortType = NoteSortType.createdAt;

  @override
  List<Note> build() {
    _repository = NoteRepository();
    final notes = _repository.getAll();
    return _applySort(notes);
  }

  // ===============================
  // CRUD
  // ===============================
  void addNote(Note note) {
    _repository.add(note);
    state = _applySort(_repository.getAll());
  }

  void updateNote(Note note) {
    _repository.update(note);
    state = _applySort(_repository.getAll());
  }

  void deleteNote(String id) {
    _repository.delete(id);
    state = _applySort(_repository.getAll());
  }

  // ===============================
  // SORT
  // ===============================
  void changeSort(NoteSortType type) {
    _sortType = type;
    state = _applySort([...state]);
  }

  List<Note> _applySort(List<Note> notes) {
    switch (_sortType) {
      case NoteSortType.updatedAt:
        notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        break;

      case NoteSortType.custom:
        // future custom sorting
        break;

      case NoteSortType.createdAt:
      notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
    }
    return notes;
  }
}
