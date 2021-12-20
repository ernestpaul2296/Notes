import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:surfwar_flutter/common_widgets/create_note_textfield.dart';
import 'package:surfwar_flutter/common_widgets/text_field_widget.dart';
import 'package:surfwar_flutter/common_widgets/text_widget.dart';
import 'package:surfwar_flutter/models/models.dart';
import 'package:surfwar_flutter/pages/note_page/note_page_components/line_component_widget.dart';
import 'package:surfwar_flutter/pages/note_page/note_page_components/line_widget.dart';

import 'package:surfwar_flutter/services/global.dart';
import 'package:surfwar_flutter/services/notes.dart';

import 'package:surfwar_flutter/styles/styles.dart';

import 'note_page_components/note_page_components.dart';

class NotePage extends StatefulWidget {
  String id;
  NotePage({required this.id});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Align(
        alignment: Alignment.topRight,
        child: NotePageButtons(
          id: widget.id,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ValueListenableBuilder(
          valueListenable: Global.boxes[BOX_NAME.NOTES_BOX]!.listenable(),
          builder: (context, Box box, wid) {
            List<Widget> widgetsToDisplay = [];
            widgetsToDisplay.add(GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: GestureDetector(
                onTap: () {
                  print('taped screen');
                },
                child: GridPaper(
                  color: AppColors.grey.withOpacity(0.4),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
            ));

            Note note = box.get(widget.id);

            note.noteContent.forEach((e) {
              switch (e.noteContentType) {
                case 'CIRCLE':
                  widgetsToDisplay
                      .add(CircleComponentWidget(id: widget.id, e: e));
                  return;
                case 'CONTAINER':
                  widgetsToDisplay
                      .add(ContainerComponentWidget(id: widget.id, e: e));
                  return;
                case 'SQUARE':
                  widgetsToDisplay
                      .add(SquareComponentWidget(id: widget.id, e: e));
                  return;
                case 'LINE':
                  print('found line');
                  widgetsToDisplay.add(
                    LineWidget(
                      id: widget.id,
                      e: e,
                      endPointX: e.endPointX!,
                      centreX: e.centreX!,
                      centreY: e.centreY!,
                      controlPointX: e.controlPointX!,
                      controlPointY: e.controlPointY!,
                      endPointY: e.endPointY!,
                      startPointX: e.startPointX!,
                      startPointY: e.startPointY!,
                    ),
                  );
                  return;
                case 'TEXT':
                  TextEditingController textController =
                      TextEditingController(text: e.text);
                  widgetsToDisplay.add(Positioned(
                    top: e.positionY,
                    left: e.positionX,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());

                        TextEditingController fontSizeController =
                            TextEditingController(text: e.fontSize.toString());
                        fontSizeController.text == null
                            ? fontSizeController.text = '12'
                            : e.fontSize;
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            List<Color> colors = [
                              AppColors.black,
                              AppColors.green,
                              AppColors.grey,
                              AppColors.orange,
                              AppColors.purple,
                              AppColors.red,
                              AppColors.yellow
                            ];
                            Color color = Color(e.color);
                            Color borderColor = Color(e.borderColor);
                            // TextEditingController textController =
                            //    TextEditingController(text: e.text);
                            TextEditingController positionXController =
                                TextEditingController(
                                    text: e.positionX.toString());
                            TextEditingController positionYController =
                                TextEditingController(
                                    text: e.positionY.toString());

                            return GestureDetector(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(24))),
                                  margin: EdgeInsets.all(24),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // Text(e.text),
                                      // SizedBox(
                                      //   height: 24,
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     Text('Text'),
                                      //     Spacer(),
                                      //     CreateNoteTextFieldWidget(
                                      //       height: 40,
                                      //       hint: '',
                                      //       controller: textController,
                                      //     )
                                      //   ],
                                      // ),
                                      Row(
                                        children: [
                                          Text('Font Size'),
                                          Spacer(),
                                          TextFieldWidget(
                                            controller: fontSizeController,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 48,
                                      ),
                                      Row(
                                        children: [
                                          Text('Color'),
                                          Spacer(),
                                          Container(
                                            height: 40,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: colors.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      color = colors[index];
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: CircleAvatar(
                                                        radius: 12,
                                                        backgroundColor:
                                                            colors[index],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Note note = Global
                                                .boxes[BOX_NAME.NOTES_BOX]!
                                                .get(widget.id);

                                            NoteContent content = note
                                                .noteContent
                                                .firstWhere((element) =>
                                                    e.noteContentId ==
                                                    e.noteContentId);
                                            note.noteContent.removeWhere(
                                                (element) =>
                                                    element.noteContentId ==
                                                    e.noteContentId);

                                            NoteContent updatedContent =
                                                NoteContent(
                                              fontSize: fontSizeController
                                                          .text.length >
                                                      0
                                                  ? double.parse(
                                                      fontSizeController.text)
                                                  : e.fontSize,
                                              borderColor: borderColor.hashCode,
                                              color: color.hashCode,
                                              height: e.height,
                                              noteContentId: e.noteContentId,
                                              noteContentType:
                                                  e.noteContentType,
                                              width: e.width,
                                              positionX: double.parse(
                                                  positionXController.text),
                                              positionY: double.parse(
                                                  positionYController.text),
                                              text: textController.text,
                                            );
                                            note.noteContent
                                                .add(updatedContent);
                                            Global.boxes[BOX_NAME.NOTES_BOX]!
                                                .put(widget.id, note);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                              'Save changes to component')),
                                      TextButton(
                                          onPressed: () {
                                            Note note = Global
                                                .boxes[BOX_NAME.NOTES_BOX]!
                                                .get(widget.id);

                                            note.noteContent.removeWhere(
                                                (element) =>
                                                    element.noteContentId ==
                                                    e.noteContentId);

                                            box.put(widget.id, note);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Delete Component')),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Draggable(
                        onDragUpdate: (DragUpdateDetails details) {
                          e.text = textController.text;
                          setState(() {
                            e.positionX = details.globalPosition.dx;
                            e.positionY = details.globalPosition.dy;
                          });
                        },
                        onDragStarted: () {},
                        onDragCompleted: () {
                          Note note =
                              Global.boxes[BOX_NAME.NOTES_BOX]!.get(widget.id);
                          note.noteContent.removeWhere((element) =>
                              element.noteContentId == e.noteContentId);
                          e.text = textController.text;
                          note.noteContent.add(e);
                          NotesService.saveNoteLocally(note);
                        },
                        onDragEnd: (DraggableDetails details) {},
                        data: {},
                        dragAnchorStrategy: pointerDragAnchorStrategy,
                        feedback: Container(
                          color: Colors.transparent,
                          width: 30,
                          height: 30,
                        ),
                        child: Stack(alignment: Alignment.topRight, children: [
                          Container(
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
                              border: Border.all(
                                  color: Colors.transparent, width: 1),
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width / 3,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 0.0,
                              ),
                              child: TextField(
                                maxLines: null,
                                onChanged: (event) {
                                  // Note note = Global.boxes[BOX_NAME.NOTES_BOX]!
                                  //     .get(widget.id);
                                  // note.noteContent.removeWhere((element) =>
                                  //     element.noteContentId == e.noteContentId);
                                  e.text = textController.text;
                                  // note.noteContent.add(e);
                                  // NotesService.saveNoteLocally(note);
                                },
                                onEditingComplete: () {
                                  Note note = Global.boxes[BOX_NAME.NOTES_BOX]!
                                      .get(widget.id);
                                  note.noteContent.removeWhere((element) =>
                                      element.noteContentId == e.noteContentId);
                                  e.text = textController.text;

                                  note.noteContent.add(e);
                                  FocusNode().unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  NotesService.saveNoteLocally(note);
                                },
                                onSubmitted: (event) {
                                  Note note = Global.boxes[BOX_NAME.NOTES_BOX]!
                                      .get(widget.id);
                                  note.noteContent.removeWhere((element) =>
                                      element.noteContentId == e.noteContentId);
                                  e.text = textController.text;
                                  note.noteContent.add(e);
                                  FocusNode().unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
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
                                    color: Color(e.color),
                                    fontSize: e.fontSize),
                                decoration: InputDecoration(
                                  hintText: 'Add Text',
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
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Note note = Global.boxes[BOX_NAME.NOTES_BOX]!
                                  .get(widget.id);
                              note.noteContent.removeWhere((element) =>
                                  element.noteContentId == e.noteContentId);

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
                    ),
                  ));
                  return;
                case 'DIAMOND':
                  widgetsToDisplay.add(DiamondComponentWidget(
                    id: widget.id,
                    e: e,
                  ));
                  return;
                case 'TRIANGLE':
                  widgetsToDisplay
                      .add(TriangleComponentWidget(id: widget.id, e: e));
                  return;
              }
            });

            return InteractiveViewer(
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
