import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_controller.dart';
import '../../../data/models/note_model.dart';

class NoteEditView extends StatefulWidget {
  const NoteEditView({super.key});

  @override
  State<NoteEditView> createState() => _NoteEditViewState();
}

class _NoteEditViewState extends State<NoteEditView> {
  final titleC = TextEditingController();
  final contentC = TextEditingController();
  NoteModel? note;

  @override
  void initState() {
    super.initState();
    note = Get.arguments;
    if (note != null) {
      titleC.text = note!.title;
      contentC.text = note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotesController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'Tambah Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleC,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: contentC,
              decoration: const InputDecoration(labelText: 'Isi'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (note == null) {
                  controller.addNote(titleC.text, contentC.text);
                } else {
                  controller.updateNote(
                    note!.id!,
                    titleC.text,
                    contentC.text,
                  );
                }
                Get.back();
              },
              child: const Text('Simpan'),
            )
          ],
        ),
      ),
    );
  }
}
