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
  String _searchQuery = '';

  @override
  List<Note> build() {
    _repository = NoteRepository();
    final notes = _repository.getAll();
    return _applyFilterAndSort(notes);
  }

  // ===============================
  // CRUD
  // ===============================
  void addNote(Note note) {
    _repository.add(note);
    state = _applyFilterAndSort(_repository.getAll());
  }

  void updateNote(Note note) {
    _repository.update(note);
    state = _applyFilterAndSort(_repository.getAll());
  }

  void deleteNote(String id) {
    _repository.delete(id);
    state = _applyFilterAndSort(_repository.getAll());
  }

  // ===============================
  // SORT
  // ===============================
  void changeSort(NoteSortType type) {
    _sortType = type;
    state = _applyFilterAndSort([...state]);
  }
  // SEARCH

  void search(String query) {
    _searchQuery = query.toLowerCase();
    state = _applyFilterAndSort(_repository.getAll());
  }

  List<Note> _applyFilterAndSort(List<Note> notes) {
    // FILTER
    if (_searchQuery.isNotEmpty) {
      notes = notes.where((note) {
        return note.title.toLowerCase().contains(_searchQuery) ||
            note.content.toLowerCase().contains(_searchQuery);
      }).toList();
    }
// SORT
    switch (_sortType) {
      case NoteSortType.updatedAt:
        notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        break;

      case NoteSortType.custom:
        break;

      case NoteSortType.createdAt:
      default:
        notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
    }

    return notes;
  }
}
