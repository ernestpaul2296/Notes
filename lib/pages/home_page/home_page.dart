import 'package:flutter/material.dart';
import 'package:surfwar_flutter/models/note.dart';

import 'package:surfwar_flutter/services/global.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:surfwar_flutter/services/notes.dart';
import 'package:surfwar_flutter/services/utils.dart';

import 'package:surfwar_flutter/styles/styles.dart';
import './home_page_components/home_page_components.dart';

class HomePage extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Widget build(BuildContext context) {
    String id = Utils.getSecureString(20);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CreateNoteWidget(
                  titleController: titleController,
                  descriptionController: descriptionController,
                  id: id);
            },
          );
        },
        foregroundColor: Colors.black,
        backgroundColor: AppColors.orange,
        child: Icon(
          Icons.add,
          size: 48,
          color: AppColors.white,
        ),
      ),
      backgroundColor: AppColors.grey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ValueListenableBuilder(
          valueListenable: Global.boxes[BOX_NAME.NOTES_BOX]!.listenable(),
          builder: (context, Box box, wid) {
            List<Note> notes = List<Note>.from(box.values);

            return Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage('assets/background.jpg'),
                      fit: BoxFit.cover),
                ),
                child: notes.length == 0
                    ? EmptyNoteStateWidget()
                    : NotesWidgetsComponent(notes: notes));
          },
        ),
      ),
    );
  }
}
