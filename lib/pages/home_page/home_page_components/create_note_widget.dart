import 'package:flutter/material.dart';
import 'package:surfwar_flutter/common_widgets/create_note_textfield.dart';
import 'package:surfwar_flutter/models/note.dart';
import 'package:surfwar_flutter/services/notes.dart';
import 'package:surfwar_flutter/styles/styles.dart';

class CreateNoteWidget extends StatelessWidget {
  const CreateNoteWidget({
    Key? key,
    required this.titleController,
    required this.descriptionController,
    required this.id,
  }) : super(key: key);

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final String id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(24))),
          margin: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CreateNoteTextFieldWidget(
                height: 40,
                controller: titleController,
                hint: 'Title',
              ),
              CreateNoteTextFieldWidget(
                height: 200,
                controller: descriptionController,
                hint: 'Description',
              ),
              SizedBox(
                height: 24,
              ),
              TextButton(
                  onPressed: () {
                    if (titleController.text.length > 0) {
                      NotesService.saveNoteLocally(Note(
                          id: id,
                          title: titleController.text,
                          description: descriptionController.text,
                          createdOn: DateTime.now(),
                          lastEditedOn: DateTime.now(),
                          noteContent: []));
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Create Note',
                    style: AppFonts.noteSubTitle,
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: AppFonts.noteSubTitle,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
