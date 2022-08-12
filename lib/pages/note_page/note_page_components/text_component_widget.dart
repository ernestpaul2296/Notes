import 'package:flutter/material.dart';
import 'package:surfwar_flutter/pages/note_page/view_model/note_page_viewmodel.dart';
import 'package:surfwar_flutter/services/global.dart';

import '../../../models/note.dart';
import '../../../models/note_content.dart';
import '../../../services/notes.dart';
import '../../../styles/styles.dart';

class TextComponentWidget extends StatefulWidget {
  TextComponentWidget({required this.e, required this.id});

  NoteContent e;
  String id;

  @override
  State<TextComponentWidget> createState() => _TextComponentWidgetState();
}

class _TextComponentWidgetState extends State<TextComponentWidget> {
  TextEditingController textController = TextEditingController();

  double? initialPositionX;
  double? initialPositionY;

  NoteContent? checkIfComponentsExistsNearby(double dx, double dy) {
    Note note = Global.boxes[BOX_NAME.NOTES_BOX]!.get(widget.id);
    List<NoteContent> noteContents = note.noteContent;
    List<NoteContent> noteContentsNearby = noteContents
        .where((e) =>
            (e.positionX - dx).abs() < 100 &&
            (e.positionY - dy).abs() < 100 &&
            e.noteContentId != widget.e.noteContentId)
        .toList();

    if (noteContentsNearby.length > 0) {
      print('here!!!');
      print(noteContentsNearby[0].data);
      return noteContentsNearby[0];
    } else
      return null;
  }

  Widget build(BuildContext context) {
    return Positioned(
      top: widget.e.positionY - 20,
      left: widget.e.positionX - 60,
      child: Draggable(
        onDragUpdate: (DragUpdateDetails details) {
          print('On drag update');
          widget.e.data = textController.text;

          setState(() {
            widget.e.positionX = details.localPosition.dx;
            widget.e.positionY = details.localPosition.dy;
          });
        },
        onDragStarted: () {
          initialPositionX = widget.e.positionX;
          initialPositionY = widget.e.positionY;
        },
        // onDragCompleted: () {
        //   print('Print from drag complete');
        //   Note note = Global.boxes[BOX_NAME.NOTES_BOX]!.get(widget.id);
        //   note.noteContent.removeWhere(
        //       (element) => element.noteContentId == widget.e.noteContentId);
        //   widget.e.data = textController.text;
        //   note.noteContent.add(widget.e);
        //   NotesService.saveNoteLocally(note);
        // },
        onDragEnd: (details) {
          print('Print from drag End');
          // NoteContent? contentNearby = checkIfComponentsExistsNearby(
          //     widget.e.positionX, widget.e.positionY);

          // if (contentNearby != null) {
          //   NotesService.connectComponents(
          //       widget.id, contentNearby.noteContentId, widget.e.noteContentId);
          //   setState(() {
          //     widget.e.positionX = initialPositionX!;
          //     widget.e.positionY = initialPositionY!;
          //   });
          // }

          Note note = Global.boxes[BOX_NAME.NOTES_BOX]!.get(widget.id);

          note.noteContent.removeWhere(
              (element) => element.noteContentId == widget.e.noteContentId);

          widget.e.data = textController.text;
          widget.e.positionX = widget.e.positionX;
          widget.e.positionY = widget.e.positionY;

          note.noteContent.add(widget.e);

          NotesService.saveNoteLocally(note);
        },
        dragAnchorStrategy: pointerDragAnchorStrategy,
        feedback: Container(
          color: Colors.transparent,
          width: 30,
          height: 30,
        ),
        child: Stack(alignment: Alignment.topRight, children: [
          GestureDetector(
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: ((context) => Container(
                        width: 100,
                        height: 100,
                        color: Colors.amber,
                      )));
            },
            child: Container(
              margin: EdgeInsets.only(left: 6),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: AppColors.grey.withOpacity(0.3),
                    offset: Offset.zero,
                  )
                ],
                border: Border.all(color: Colors.transparent, width: 1),
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              width: MediaQuery.of(context).size.width / 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0.0,
                ),
                child: ValueListenableBuilder(
                    valueListenable:
                        NotePageViewModel.of(context).isItalicEnable,
                    builder: (context, italics, _) {
                      return ValueListenableBuilder(
                          valueListenable:
                              NotePageViewModel.of(context).isUnderlined,
                          builder: (context, underlined, _) {
                            return ValueListenableBuilder(
                                valueListenable:
                                    NotePageViewModel.of(context).isBoldEnable,
                                builder: (context, enabled, _) {
                                  return TextField(
                                    onTap: () {
                                      NotePageViewModel.of(context)
                                          .setSelectedComponent(
                                              widget.e.noteContentId);
                                    },

                                    maxLines: null,
                                    onChanged: (event) {
                                      widget.e.data = textController.text;
                                    },
                                    onEditingComplete: () {
                                      Note note = Global
                                          .boxes[BOX_NAME.NOTES_BOX]!
                                          .get(widget.id);
                                      note.noteContent.removeWhere((element) =>
                                          element.noteContentId ==
                                          widget.e.noteContentId);
                                      widget.e.data = textController.text;

                                      note.noteContent.add(widget.e);
                                      FocusNode().unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      print('Saving note on EDIT-COMEPLETE');
                                      NotesService.saveNoteLocally(note);
                                    },
                                    onSubmitted: (event) {
                                      Note note = Global
                                          .boxes[BOX_NAME.NOTES_BOX]!
                                          .get(widget.id);
                                      note.noteContent.removeWhere((element) =>
                                          element.noteContentId ==
                                          widget.e.noteContentId);
                                      widget.e.data = textController.text;
                                      note.noteContent.add(widget.e);
                                      FocusNode().unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      print('Saving note on SUBMITTED');
                                      NotesService.saveNoteLocally(note);
                                    },
                                    textInputAction: TextInputAction.done,
                                    autofocus: false,
                                    //keyboardType: TextInputType.number,
                                    controller: textController,
                                    cursorColor: Colors.black,
                                    scrollPadding: EdgeInsets.symmetric(
                                      horizontal: 0,
                                    ),
                                    style: TextStyle(
                                        color: Color(widget.e.style.colorCode),
                                        fontStyle:
                                            widget.e.style.textItalics == true
                                                ? FontStyle.italic
                                                : FontStyle.normal,
                                        fontWeight:
                                            widget.e.style.textThinkness == true
                                                ? FontWeight.w900
                                                : FontWeight.normal,
                                        decoration:
                                            widget.e.style.textUnderline == true
                                                ? TextDecoration.underline
                                                : TextDecoration.none,
                                        fontSize: widget.e.fontSize),

                                    decoration: const InputDecoration(
                                      hintText: 'Add Text',
                                      hintStyle: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none),
                                      // suffixIcon: Icon(Icons.edit),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 0),
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),

                                      filled: true,
                                      fillColor: Colors.transparent,
                                    ),
                                  );
                                });
                          });
                    }),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Note note = Global.boxes[BOX_NAME.NOTES_BOX]!.get(widget.id);
              note.noteContent.removeWhere(
                  (element) => element.noteContentId == widget.e.noteContentId);

              note.noteContent.forEach((elm) {
                if (elm.connectedComponents.contains(widget.e.noteContentId)) {
                  elm.connectedComponents.remove(widget.e.noteContentId);
                }
              });

              NotesService.saveNoteLocally(note);
            },
            child: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.black,
              child: Icon(
                Icons.close,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
