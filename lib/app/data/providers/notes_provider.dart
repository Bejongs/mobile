import '../models/note_model.dart';

class NotesProvider {
  final List<NoteModel> _notes = [];

  List<NoteModel> getNotes() {
    return _notes;
  }

  void addNote(String title, String content) {
    final note = NoteModel(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      content: content,
    );
    _notes.add(note);
  }

  void updateNote(int id, String title, String content) {
    final index = _notes.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notes[index] =
          NoteModel(id: id, title: title, content: content);
    }
  }

  void deleteNote(int id) {
    _notes.removeWhere((n) => n.id == id);
  }
}
