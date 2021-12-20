import 'package:flutter/material.dart';
import 'package:surfwar_flutter/common_widgets/text_field_widget.dart';
import 'package:surfwar_flutter/models/models.dart';
import 'package:surfwar_flutter/services/global.dart';
import 'package:surfwar_flutter/services/notes.dart';
import 'package:surfwar_flutter/styles/styles.dart';

class CircleComponentWidget extends StatefulWidget {
  final NoteContent e;
  final String id;
  CircleComponentWidget({
    required this.e,
    required this.id,
  });

  @override
  State<CircleComponentWidget> createState() => _CircleComponentWidgetState();
}

class _CircleComponentWidgetState extends State<CircleComponentWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.e.positionY,
      left: widget.e.positionX,
      child: GestureDetector(
        onTap: () {
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
              Color color = Color(widget.e.color);
              Color borderColor = Color(widget.e.borderColor);
              TextEditingController heightController =
                  TextEditingController(text: widget.e.height.toString());
              TextEditingController widthController =
                  TextEditingController(text: widget.e.width.toString());
              TextEditingController positionXController =
                  TextEditingController(text: widget.e.positionX.toString());
              TextEditingController positionYController =
                  TextEditingController(text: widget.e.positionY.toString());

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
                    margin: EdgeInsets.symmetric(vertical: 100, horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            Text('Diameter'),
                            Spacer(),
                            TextFieldWidget(
                              controller: heightController,
                            )
                          ],
                        ),
                        //  Spacer(),//
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
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: colors.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        color = colors[index];
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: colors[index],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Border Color'),
                            Spacer(),
                            Container(
                              height: 40,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: colors.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        borderColor = colors[index];
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: colors[index],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 48,
                        ),
                        TextButton(
                            onPressed: () {
                              Note note = Global.boxes[BOX_NAME.NOTES_BOX]!
                                  .get(widget.id);

                              NoteContent content = note.noteContent.firstWhere(
                                  (element) =>
                                      widget.e.noteContentId ==
                                      widget.e.noteContentId);
                              note.noteContent.removeWhere((element) =>
                                  element.noteContentId ==
                                  widget.e.noteContentId);

                              NoteContent updatedContent = NoteContent(
                                borderColor: borderColor.hashCode,
                                color: color.hashCode,
                                height: double.parse(heightController.text),
                                noteContentId: widget.e.noteContentId,
                                noteContentType: widget.e.noteContentType,
                                width: double.parse(heightController.text),
                                positionX:
                                    double.parse(positionXController.text),
                                positionY:
                                    double.parse(positionYController.text),
                                text: widget.e.text,
                              );
                              note.noteContent.add(updatedContent);
                              Global.boxes[BOX_NAME.NOTES_BOX]!
                                  .put(widget.id, note);
                              Navigator.of(context).pop();
                            },
                            child: Text('Save changes to component')),
                        TextButton(
                            onPressed: () {
                              Note note = Global.boxes[BOX_NAME.NOTES_BOX]!
                                  .get(widget.id);

                              note.noteContent.removeWhere((element) =>
                                  element.noteContentId ==
                                  widget.e.noteContentId);

                              Global.boxes[BOX_NAME.NOTES_BOX]!
                                  .put(widget.id, note);
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
            setState(() {
              widget.e.positionX = details.globalPosition.dx;
              widget.e.positionY = details.globalPosition.dy;
            });
          },
          onDragStarted: () {},
          onDragCompleted: () {
            Note note = Global.boxes[BOX_NAME.NOTES_BOX]!.get(widget.id);
            note.noteContent.removeWhere(
                (element) => element.noteContentId == widget.e.noteContentId);
            note.noteContent.add(widget.e);
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
          child: Container(
            height: widget.e.height,
            width: widget.e.width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(widget.e.borderColor)),
              color: Color(widget.e.color),
            ),
          ),
        ),
      ),
    );
  }
}

//  Container(
//           height: e.height,
//           width: e.width,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(color: Color(e.borderColor)),
//             color: Color(e.color),
//           ),
//         ),


//  Draggable(
//           onDragUpdate: (DragUpdateDetails details) {
//             setState(() {
//               widget.startPointX = details.globalPosition.dx;
//               widget.startPointY = details.globalPosition.dy;
//             });
//           },
//           onDragStarted: () {},
//           onDragCompleted: () {},
//           onDragEnd: (DraggableDetails details) {},
//           data: {},
//           dragAnchorStrategy: pointerDragAnchorStrategy,
//           feedback: Container(
//             color: Colors.transparent,
//             width: 30,
//             height: 30,
//           ),
//           child: Icon(
//             Icons.circle_rounded,
//             color: Colors.red,
//           ),
//         ),