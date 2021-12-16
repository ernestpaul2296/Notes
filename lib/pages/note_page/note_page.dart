import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:surfwar_flutter/common_widgets/create_note_textfield.dart';
import 'package:surfwar_flutter/common_widgets/text_field_widget.dart';
import 'package:surfwar_flutter/models/models.dart';
import 'package:surfwar_flutter/pages/note_page/note_page_components/line_component_widget.dart';

import 'package:surfwar_flutter/services/global.dart';

import 'package:surfwar_flutter/styles/styles.dart';

import 'note_page_components/note_page_components.dart';

class NotePage extends StatelessWidget {
  String id;
  NotePage({required this.id});

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: NotePageButtons(id: id),
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
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ));

            Note note = box.get(id);

            note.noteContent.forEach((e) {
              switch (e.noteContentType) {
                case 'HORIZONTAL_LINE':
                  widgetsToDisplay.add(LineComponentWidget(id: id, e: e));
                  return;
                case 'VERTICAL_LINE':
                  widgetsToDisplay.add(LineComponentWidget(id: id, e: e));
                  return;
                case 'CIRCLE':
                  widgetsToDisplay.add(CircleComponentWidget(id: id, e: e));
                  return;
                case 'CONTAINER':
                  widgetsToDisplay.add(ContainerComponentWidget(id: id, e: e));
                  return;
                case 'SQUARE':
                  widgetsToDisplay.add(SquareComponentWidget(id: id, e: e));
                  return;
                case 'TEXT':
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
                            TextEditingController textController =
                                TextEditingController(text: e.text);
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
                                    children: [
                                      Text(e.text),
                                      SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          Text('Text'),
                                          Spacer(),
                                          CreateNoteTextFieldWidget(
                                            height: 40,
                                            hint: '',
                                            controller: textController,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('Font Size'),
                                          Spacer(),
                                          TextFieldWidget(
                                            controller: fontSizeController,
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
                                                .get(id);

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
                                                  : 12.0,
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
                                                .put(id, note);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                              'Save changes to component')),
                                      TextButton(
                                          onPressed: () {
                                            Note note = Global
                                                .boxes[BOX_NAME.NOTES_BOX]!
                                                .get(id);

                                            note.noteContent.removeWhere(
                                                (element) =>
                                                    element.noteContentId ==
                                                    e.noteContentId);

                                            box.put(id, note);
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
                      child: Text(
                        e.text,
                        style: TextStyle(
                          color: Color(e.color),
                          fontSize: e.fontSize ?? 24,
                        ),
                      ),
                    ),
                  ));
                  return;
                case 'DIAMOND':
                  widgetsToDisplay.add(DiamondComponentWidget(
                    id: id,
                    e: e,
                  ));
                  return;
                case 'TRIANGLE':
                  widgetsToDisplay.add(TriangleComponentWidget(id: id, e: e));
                  return;
              }
            });

            return Stack(
              children: widgetsToDisplay,
            );
          },
        ),
      ),
    );
  }
}
