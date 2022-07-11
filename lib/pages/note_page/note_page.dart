import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:surfwar_flutter/models/models.dart';
import 'package:surfwar_flutter/pages/note_page/note_page_components/line_component_widget.dart';
import 'package:surfwar_flutter/pages/note_page/note_page_components/note_page_viewmodel.dart';



import 'package:surfwar_flutter/services/global.dart';

import 'package:surfwar_flutter/services/notes.dart';

import 'package:surfwar_flutter/styles/styles.dart';


import '../home_page/home_page.dart';
import 'note_page_components/text_component_widget.dart';

import 'note_page_components/note_page_components.dart';

class NotePage extends StatefulWidget {
  String id;
  NotePage({required this.id});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {

  @override
  void initState() {

    super.initState();
  }


  TransformationController _transformationController =
      TransformationController();

  Widget build(BuildContext context) {

    return Scaffold(

      floatingActionButton: FloatingButtonWidget(),

      body: ChangeNotifierProvider(

      create: (_) => NotePageViewModel(noteId: widget.id),

      child: GestureDetector(
      
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },

            child: ValueListenableBuilder(
      
              valueListenable: Global.boxes[BOX_NAME.NOTES_BOX]!.listenable(),
      
              builder: (context, Box box, wid) {
      
                Note note = box.get(widget.id);
      
                List<Widget> widgetsToDisplay = NotePageViewModel(noteId: widget.id).returnWidgetlist();
                    
                if (note.transformationControllerValue != null) {
                  _transformationController.value =
                      Matrix4.fromList(note.transformationControllerValue!);
                  note.transformationControllerValue!;
                } 

              return 

              InteractiveViewer(
                      
                      transformationController: _transformationController,

                      onInteractionUpdate: (details) {
                
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
        
      ),
    );
  }
}













  // note.noteContent.forEach((e) {
            //   e.connectedComponents.forEach((element) {
            //     NoteContent connectedToComponent = noteContents
            //         .firstWhere((el) => el.noteContentId == element);

            //     widgetsToDisplay.add(LineComponentWidget(
            //       componentA: Offset(e.positionX, e.positionY),
            //       componentB: Offset(connectedToComponent.positionX,
            //           connectedToComponent.positionY),
            //     ));
            //   });
            // });
            // widgetsToDisplay.add(GridPaperWidget(noteId: noteId));
            // note.noteContent.forEach((e) {
            //   switch (e.noteContentType) {
            //     case 'TEXT':
            //       TextEditingController textController =
            //           TextEditingController(text: e.data);
            //       widgetsToDisplay.add(TextComponentWidget(
            //         e: e,
            //         id: widget.id,
            //       ));
            //       return;
            //   }
            // });