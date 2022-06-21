import 'package:surfwar_flutter/models/note.dart';
import 'package:surfwar_flutter/models/note_content.dart';
import 'package:surfwar_flutter/services/global.dart';

class NotesService {
  static saveNoteLocally(Note note) {
    print('SAVED NOTE');
    Global.boxes[BOX_NAME.NOTES_BOX]!.put(note.id, note);
  }

  static addNoteContent(String id, NoteContent content) {
    Note note = Global.boxes[BOX_NAME.NOTES_BOX]!.get(id);
    note.noteContent.add(content);
    Global.boxes[BOX_NAME.NOTES_BOX]!.put(id, note);
  }

  deleteNoteLocally(String id) {
    print('delete function');
    Global.boxes[BOX_NAME.NOTES_BOX]!.delete((id));
  }

  static connectComponents(
      String noteId, String contentAId, String contentBId) {
    Note note = Global.boxes[BOX_NAME.NOTES_BOX]!.get(noteId);

    NoteContent noteContentA = note.noteContent
        .firstWhere((element) => element.noteContentId == contentAId);

    NoteContent noteContentB = note.noteContent
        .firstWhere((element) => element.noteContentId == contentBId);

    note.noteContent
        .removeWhere((element) => element.noteContentId == contentAId);

    note.noteContent
        .removeWhere((element) => element.noteContentId == contentBId);

    noteContentA.connectedComponents.add(contentBId);
    noteContentB.connectedComponents.add(contentAId);
    note.noteContent.add(noteContentA);
    note.noteContent.add(noteContentB);

    Global.boxes[BOX_NAME.NOTES_BOX]!.put(noteId, note);
  }
}
