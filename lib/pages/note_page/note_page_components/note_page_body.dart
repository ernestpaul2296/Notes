




import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:surfwar_flutter/services/global.dart';

import '../../../models/note.dart';
import '../../../services/notes.dart';
import '../view_model/note_page_viewmodel.dart';
import 'edit_text_style_widget.dart';

class NotePageBody extends StatelessWidget {
  final String noteId;
  NotePageBody({required this.noteId});

  TransformationController _transformationController =
      TransformationController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (p0, isKeyboardVisible) {
      NotePageViewModel.of(context)
          .setValueForKeyboardVisibility(isKeyboardVisible);
      return ValueListenableBuilder(
        valueListenable: Global.boxes[BOX_NAME.NOTES_BOX]!.listenable(),
        builder: (context, Box box, wid) {
          Note note = box.get(noteId);

          List<Widget> widgetsToDisplay =
              NotePageViewModel(noteId: noteId).returnWidgetlist();

          if (note.transformationControllerValue != null) {
            _transformationController.value =
                Matrix4.fromList(note.transformationControllerValue!);
            note.transformationControllerValue!;
          }

          return Stack(
            children: [
              InteractiveViewer(
                transformationController: _transformationController,
                onInteractionUpdate: (details) {
                  Note note = Global.boxes[BOX_NAME.NOTES_BOX]!.get(noteId);

                  note.transformationControllerValue =
                      _transformationController.value.storage;

                  NotesService.saveNoteLocally(note);
                },
                minScale: 0.1,
                maxScale: 4,
                panEnabled: true,
                scaleEnabled: true,
                child: Stack(
                  children: widgetsToDisplay,
                ),
              ),
              EditTextStyleWidget(noteId: noteId)
            ],
          );
        },
      );
    });
  }
}

