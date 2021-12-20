import 'package:surfwar_flutter/models/note.dart';
import 'package:surfwar_flutter/models/note_content.dart';
import 'package:surfwar_flutter/services/global.dart';

class NotesService {
  static saveNoteLocally(Note note) {
    print('SAVING NOTE');
    Global.boxes[BOX_NAME.NOTES_BOX]!.put(note.id, note);
  }

  static addNoteContent(String id, NoteContent content) {
    Note note = Global.boxes[BOX_NAME.NOTES_BOX]!.get(id);
    note.noteContent.add(content);
    Global.boxes[BOX_NAME.NOTES_BOX]!.put(id, note);
  }

  deleteNoteLocally(int id) {
    Global.boxes[BOX_NAME.NOTES_BOX]!.deleteAt(id);
  }
}
