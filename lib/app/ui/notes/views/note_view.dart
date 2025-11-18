import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_controller.dart';

class NotesView extends GetView<NotesController> {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/note-edit'),
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (controller.notes.isEmpty) {
          return const Center(child: Text('Belum ada catatan'));
        }
        return ListView.builder(
          itemCount: controller.notes.length,
          itemBuilder: (_, i) {
            final note = controller.notes[i];
            return ListTile(
              title: Text(note.title),
              subtitle: Text(note.content),
              onTap: () => Get.toNamed('/note-edit', arguments: note),
            );
          },
        );
      }),
    );
  }
}
