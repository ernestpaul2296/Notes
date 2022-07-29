import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surfwar_flutter/models/note.dart';
import 'package:surfwar_flutter/pages/note_page/note_page_components/text_component_widget.dart';

import '../../../models/note_content.dart';
import '../../../services/global.dart';
import '../../../services/notes.dart';
import '../note_page_components/grid_paper_widget.dart';
import '../note_page_components/line_component_widget.dart';

class NotePageViewModel extends ChangeNotifier {
  String noteId;
  NotePageViewModel({required this.noteId});

  static NotePageViewModel of(BuildContext context) =>
      context.read<NotePageViewModel>();

  List<Widget> widgetList = [];

  ValueNotifier<bool> isKeyBoardVisible = ValueNotifier(false);
  ValueNotifier<bool> isBoldEnable = ValueNotifier(false);
  ValueNotifier<bool> isItalicEnable = ValueNotifier(false);
  ValueNotifier<bool> isUnderlined = ValueNotifier(false);
  ValueNotifier<String> selectedComponent = ValueNotifier('');

  setValueForKeyboardVisibility(bool isVisible) {
    isKeyBoardVisible.value = isVisible;
  }

  setSelectedComponent(String id) {
    selectedComponent.value = id;
  }

  setBoldEnable(String noteId, String noteContentId) {
    Note note = Global.boxes[BOX_NAME.NOTES_BOX]!.get(noteId);
    List<NoteContent> noteContents = note.noteContent;
    NoteContent content = noteContents
        .firstWhere((element) => element.noteContentId == noteContentId);
    content.style.textThinkness = !content.style.textThinkness;

    noteContents
        .removeWhere((element) => element.noteContentId == noteContentId);
    noteContents.add(content);

    note.noteContent = noteContents;
    NotesService.saveNoteLocally(note);
  }

  setItalicsEnable(bool isEnabled) {
    print('Italics enabling');
    isItalicEnable.value = isEnabled;
  }

  setUnderline(bool isEnabled) {
    isUnderlined.value = isEnabled;
  }

  returnWidgetlist() {
    List<Widget> widgetsToDisplay = [];
    Note note = Global.boxes[BOX_NAME.NOTES_BOX]!.get(noteId);

    List<NoteContent> noteContents = note.noteContent;
    note.noteContent.forEach((e) {
      e.connectedComponents.forEach((element) {
        NoteContent connectedToComponent =
            noteContents.firstWhere((el) => el.noteContentId == element);

        widgetsToDisplay.add(LineComponentWidget(
          componentA: Offset(e.positionX, e.positionY),
          componentB: Offset(
              connectedToComponent.positionX, connectedToComponent.positionY),
        ));
      });
    });
    widgetsToDisplay.add(GridPaperWidget(noteId: noteId));
    note.noteContent.forEach((e) {
      switch (e.noteContentType) {
        case 'TEXT':
          TextEditingController textController =
              TextEditingController(text: e.data);
          widgetsToDisplay.add(TextComponentWidget(
            e: e,
            id: noteId,
          ));
          return;
      }
    });
    return widgetsToDisplay;
  }
}
