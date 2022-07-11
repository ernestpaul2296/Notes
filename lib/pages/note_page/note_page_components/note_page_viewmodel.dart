


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surfwar_flutter/models/note.dart';
import 'package:surfwar_flutter/pages/note_page/note_page_components/text_component_widget.dart';

import '../../../models/note_content.dart';
import '../../../services/global.dart';
import 'grid_paper_widget.dart';
import 'line_component_widget.dart';


class NotePageViewModel extends ChangeNotifier{
   String noteId;
  NotePageViewModel({required this.noteId});

 

  static NotePageViewModel of (BuildContext context) =>context.read<NotePageViewModel>();

  List<Widget> widgetList=[];

  returnWidgetlist(){

    List<Widget> widgetsToDisplay=[];

     Note note = Global.boxes[BOX_NAME.NOTES_BOX]!.get(noteId);

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