import 'package:flutter/material.dart';
import 'package:surfwar_flutter/models/note.dart';
import 'package:surfwar_flutter/models/note_content.dart';
import 'package:surfwar_flutter/services/global.dart';
import 'package:surfwar_flutter/services/notes.dart';
import 'package:surfwar_flutter/styles/styles.dart';

class TextWidget extends StatelessWidget {
  TextEditingController controller;
  NoteContent e;
  String noteId;

  TextWidget({
    required this.controller,
    required this.e,
    required this.noteId,
  });

  // final node = FocusScope.of(context);
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(35),
        ),
      ),
      width: MediaQuery.of(context).size.width / 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
        child: TextField(
          maxLines: null,
          onEditingComplete: () {
            Note note = Global.boxes[BOX_NAME.NOTES_BOX]!.get(noteId);
            note.noteContent.removeWhere(
                (element) => element.noteContentId == e.noteContentId);
            e.data = controller.text;
            note.noteContent.add(e);
            NotesService.saveNoteLocally(note);
            FocusScope.of(context).requestFocus(FocusNode());
          },
          onSubmitted: (event) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          autofocus: false,
          //keyboardType: TextInputType.number,
          controller: controller,
          cursorColor: Colors.black,
          scrollPadding: EdgeInsets.symmetric(
            horizontal: 0,
          ),
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.edit),
            contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: AppColors.white,
          ),
        ),
      ),
    );
  }
}
