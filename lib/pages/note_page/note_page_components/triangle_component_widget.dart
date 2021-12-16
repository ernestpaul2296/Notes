import 'package:flutter/material.dart';
import 'package:surfwar_flutter/common_widgets/text_field_widget.dart';
import 'package:surfwar_flutter/models/note.dart';
import 'package:surfwar_flutter/models/note_content.dart';
import 'package:surfwar_flutter/pages/note_page/note_page_components/note_page_components.dart';
import 'package:surfwar_flutter/services/global.dart';
import 'package:surfwar_flutter/styles/styles.dart';
import 'dart:math' as math;

class TriangleComponentWidget extends StatelessWidget {
  const TriangleComponentWidget({
    Key? key,
    required this.id,
    required this.e,
  }) : super(key: key);

  final String id;
  final NoteContent e;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: e.positionY,
      left: e.positionX,
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
              Color color = Color(e.color);
              Color borderColor = Color(e.borderColor);
              TextEditingController heightController =
                  TextEditingController(text: e.height.toString());
              TextEditingController widthController =
                  TextEditingController(text: e.width.toString());
              TextEditingController positionXController =
                  TextEditingController(text: e.positionX.toString());
              TextEditingController positionYController =
                  TextEditingController(text: e.positionY.toString());

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
                      children: [
                        TriangleWidget(
                            color: Color(e.color), height: 100, width: 100),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            Text('Height'),
                            Spacer(),
                            TextFieldWidget(
                              controller: heightController,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text('Width'),
                            Spacer(),
                            TextFieldWidget(
                              controller: widthController,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text('Position X'),
                            Spacer(),
                            TextFieldWidget(
                              controller: positionXController,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text('Position Y'),
                            Spacer(),
                            TextFieldWidget(
                              controller: positionYController,
                            )
                          ],
                        ),
                        Spacer(),
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
                        TextButton(
                            onPressed: () {
                              Note note =
                                  Global.boxes[BOX_NAME.NOTES_BOX]!.get(id);

                              NoteContent content = note.noteContent.firstWhere(
                                  (element) =>
                                      e.noteContentId == e.noteContentId);
                              note.noteContent.removeWhere((element) =>
                                  element.noteContentId == e.noteContentId);

                              NoteContent updatedContent = NoteContent(
                                borderColor: borderColor.hashCode,
                                color: color.hashCode,
                                height: double.parse(heightController.text),
                                noteContentId: e.noteContentId,
                                noteContentType: e.noteContentType,
                                width: double.parse(widthController.text),
                                positionX:
                                    double.parse(positionXController.text),
                                positionY:
                                    double.parse(positionYController.text),
                                text: e.text,
                              );
                              note.noteContent.add(updatedContent);
                              Global.boxes[BOX_NAME.NOTES_BOX]!.put(id, note);
                              Navigator.of(context).pop();
                            },
                            child: Text('Save changes to component')),
                        TextButton(
                            onPressed: () {
                              Note note =
                                  Global.boxes[BOX_NAME.NOTES_BOX]!.get(id);

                              note.noteContent.removeWhere((element) =>
                                  element.noteContentId == e.noteContentId);

                              Global.boxes[BOX_NAME.NOTES_BOX]!.put(id, note);
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
        child: CustomPaint(
          painter: ShapesPainter(Color(e.color)),
          child: Container(
            height: e.height,
            width: e.width,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 16),
                child: Transform.rotate(
                  angle: math.pi / 4,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
