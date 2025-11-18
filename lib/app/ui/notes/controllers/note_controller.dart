import 'package:get/get.dart';
import '../../../data/models/note_model.dart';
import '../../../data/providers/notes_provider.dart';

class NotesController extends GetxController {
  final NotesProvider provider = NotesProvider();
  final notes = <NoteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }

  void loadNotes() {
    notes.value = provider.getNotes();
  }

  void addNote(String title, String content) {
    provider.addNote(title, content);
    loadNotes();
  }

  void updateNote(int id, String title, String content) {
    provider.updateNote(id, title, content);
    loadNotes();
  }

  void deleteNote(int id) {
    provider.deleteNote(id);
    loadNotes();
  }
}
