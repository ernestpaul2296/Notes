import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:surfwar_flutter/models/models.dart';
import 'package:surfwar_flutter/pages/note_page/note_page_components/line_component_widget.dart';

import 'package:surfwar_flutter/pages/note_page/note_page_components/line_widget.dart';

import 'package:surfwar_flutter/services/global.dart';

import 'package:surfwar_flutter/services/notes.dart';

import 'package:surfwar_flutter/styles/styles.dart';

import '../../services/utils.dart';
import '../home_page/home_page.dart';
import '../home_page/home_page_components/text_component_widget.dart';

import 'note_page_components/note_page_components.dart';

class NotePage extends StatefulWidget {
  String id;
  NotePage({required this.id});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  TransformationController _transformationController =
      TransformationController();

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        backgroundColor: AppColors.grey,
        child: Icon(Icons.home),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ValueListenableBuilder(
          valueListenable: Global.boxes[BOX_NAME.NOTES_BOX]!.listenable(),
          builder: (context, Box box, wid) {
            print('VALUE LISTENED');
            List<Widget> widgetsToDisplay = [];

            // widgetsToDisplay.add(GridPaperWidget(widget: widget));

            Note note = box.get(widget.id);

            if (note.transformationControllerValue != null) {
              _transformationController.value =
                  Matrix4.fromList(note.transformationControllerValue!);
              note.transformationControllerValue!;
            } else {}
            List<NoteContent> noteContents = note.noteContent;
            note.noteContent.forEach((e) {
              e.connectedComponents.forEach((element) {
                NoteContent connectedToComponent = noteContents
                    .firstWhere((el) => el.noteContentId == element);

                widgetsToDisplay.add(LineComponentWidget(
                  componentA: Offset(e.positionX, e.positionY),
                  componentB: Offset(connectedToComponent.positionX,
                      connectedToComponent.positionY),
                ));
              });
            });
            widgetsToDisplay.add(GridPaperWidget(widget: widget));
            note.noteContent.forEach((e) {
              switch (e.noteContentType) {
                case 'TEXT':
                  TextEditingController textController =
                      TextEditingController(text: e.text);
                  widgetsToDisplay.add(TextComponentWidget(
                    e: e,
                    id: widget.id,
                  ));
                  return;
              }
            });

            return InteractiveViewer(
              transformationController: _transformationController,
              onInteractionUpdate: (details) {
                print(_transformationController.value.storage);
                Note note = Global.boxes[BOX_NAME.NOTES_BOX]!.get(widget.id);

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
            );
          },
        ),
      ),
    );
  }
}
