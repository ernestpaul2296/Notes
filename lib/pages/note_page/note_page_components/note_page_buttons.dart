import 'dart:async';

import 'package:flutter/material.dart';
import 'package:surfwar_flutter/models/note.dart';
import 'package:surfwar_flutter/models/note_content.dart';
import 'package:surfwar_flutter/pages/pages.dart';
import 'package:surfwar_flutter/services/global.dart';
import 'package:surfwar_flutter/services/notes.dart';
import 'package:surfwar_flutter/services/utils.dart';
import 'package:surfwar_flutter/styles/styles.dart';


 // widgetsToDisplay.add(NotePageButtons(
            //   id: widget.id,
            // ));

class NotePageButtons extends StatefulWidget {
  const NotePageButtons({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  State<NotePageButtons> createState() => _NotePageButtonsState();
}

class _NotePageButtonsState extends State<NotePageButtons> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Column(children: [
        AnimatedContainer(
          margin: EdgeInsets.only(top: 48),
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 10,
                color: AppColors.grey.withOpacity(0.5),
                offset: Offset.zero,
              )
            ],
          ),
          height: selected ? 480 : 50,
          duration: Duration(milliseconds: 600),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  setState(() {
                    selected = !selected;
                  });
                },
                icon: selected
                    ? Icon(
                        Icons.arrow_drop_up_sharp,
                        size: 40,
                      )
                    : Icon(
                        Icons.add,
                        size: 40,
                      ),
              ),
              TextButton(
                // backgroundColor: AppColors.white,
                onPressed: () {
                  List note = Global.boxes[BOX_NAME.NOTES_BOX]!.values.toList();

                  String contentId = Utils.getSecureString(20);
                  NotesService.addNoteContent(
                    widget.id,
                    NoteContent(
                      connectedComponents: [],
                      fontSize: 14,
                      noteContentType: 'LINE',
                      positionX: MediaQuery.of(context).size.width / 3,
                      positionY: MediaQuery.of(context).size.height / 2,
                      height: 4,
                      width: 100,
                      color: 0xff828282,
                      noteContentId: contentId,
                      borderColor: 0xff828282,
                      text: '',
                      endPointX: MediaQuery.of(context).size.width - 100,
                    
                      endPointY: 100,
                      startPointX: MediaQuery.of(context).size.width - 100,
                      startPointY: 200,
                    ),
                  );
                },
                child: Icon(
                  Icons.call_made_rounded,
                  size: 40,
                  color: Colors.black,
                ),
              ),
              // TextButton(
              //   // backgroundColor: AppColors.white,
              //   onPressed: () {
              //     String contentId = Utils.getSecureString(20);
              //     NotesService.addNoteContent(
              //         id,
              //         NoteContent(
              //             fontSize: 18,
              //             noteContentType: 'VERTICAL_LINE',
              //             positionX: MediaQuery.of(context).size.width / 2,
              //             positionY: MediaQuery.of(context).size.height / 2,
              //             height: 100,
              //             width: 4,
              //             color: 0xff828282,
              //             noteContentId: contentId,
              //             borderColor: 0xff828282,
              //             text: ''));
              //   },
              //   child: Text(
              //     '|',
              //     style: AppFonts.primaryHeader,
              //   ),
              // ),

              TextButton(
                // backgroundColor: AppColors.white,
                onPressed: () {
                  String contentId = Utils.getSecureString(20);
                  NotesService.addNoteContent(
                      widget.id,
                      NoteContent(
                        connectedComponents: [],
                          fontSize: 12,
                          noteContentType: 'TEXT',
                          positionX: 4.190923164060223e-10,
                          positionY: 1.301079244342418e-10,
                          height: 100,
                          width: 100,
                          color: 0xff828282,
                          noteContentId: contentId,
                          borderColor: 0xff828282,
                          text: ''));
                  setState(() {
                    selected = !selected;
                  });
                },
                child: Text(
                  'T',
                  style: AppFonts.primaryHeader,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              TextButton(
                //backgroundColor: AppColors.white,
                onPressed: () {
                  String contentId = Utils.getSecureString(20);
                  NotesService.addNoteContent(
                      widget.id,
                      NoteContent(
                        connectedComponents: [],
                        noteContentType: 'DIAMOND',
                        positionX: MediaQuery.of(context).size.width / 2.3,
                        positionY: MediaQuery.of(context).size.height / 2.5,
                        height: 50,
                        width: 50,
                        color: 0xffC4C4C4,
                        noteContentId: contentId,
                        borderColor: 0xffC4C4C4,
                        text: '',
                      ));
                },
                child: Transform.rotate(
                  angle: 7,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 3,
                        color: Colors.black,
                      ),
                    ),
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              TextButton(
                  // backgroundColor: AppColors.white,
                  onPressed: () {
                    String contentId = Utils.getSecureString(20);
                    NotesService.addNoteContent(
                        widget.id,
                        NoteContent(
                          connectedComponents: [],
                          noteContentType: 'CIRCLE',
                          positionX: MediaQuery.of(context).size.width / 2.3,
                          positionY: MediaQuery.of(context).size.height / 2.5,
                          height: 50,
                          width: 50,
                          color: 0xffC4C4C4,
                          noteContentId: contentId,
                          borderColor: 0xffC4C4C4,
                          text: '',
                        ));
                  },
                  child: Icon(
                    Icons.lens_outlined,
                    color: AppColors.black,
                    size: 36,
                  )),
              SizedBox(
                height: 24,
              ),
              // TextButton(
              //     //  backgroundColor: AppColors.white,
              //     onPressed: () {
              //       String contentId = Utils.getSecureString(20);
              //       NotesService.addNoteContent(
              //           widget.id,
              //           NoteContent(
              //             noteContentType: 'TRIANGLE',
              //             positionX: MediaQuery.of(context).size.width / 2,
              //             positionY: MediaQuery.of(context).size.height / 2,
              //             height: 80,
              //             width: 50,
              //             color: 0xffC4C4C4,
              //             noteContentId: contentId,
              //             borderColor: 0xffC4C4C4,
              //             text: '',
              //           ));
              //     },
              //     child: Icon(
              //       Icons.landscape_outlined,
              //       color: AppColors.black,
              //       size: 36,
              //     )),
              // SizedBox(
              //   height: 24,
              // ),
              TextButton(
                // backgroundColor: AppColors.white,
                onPressed: () {
                  String contentId = Utils.getSecureString(20);
                  NotesService.addNoteContent(
                      widget.id,
                      NoteContent(
                        connectedComponents: [],
                        noteContentType: 'CONTAINER',
                        positionX: MediaQuery.of(context).size.width / 2.3,
                        positionY: MediaQuery.of(context).size.height / 2.5,
                        height: 80,
                        width: 50,
                        color: 0xffC4C4C4,
                        noteContentId: contentId,
                        borderColor: 0xffC4C4C4,
                        text: '',
                      ));
                },
                child: Container(
                  height: 36,
                  width: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 3,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              TextButton(
                // backgroundColor: AppColors.white,
                onPressed: () {
                  String contentId = Utils.getSecureString(20);
                  NotesService.addNoteContent(
                      widget.id,
                      NoteContent(
                        connectedComponents: [],
                        noteContentType: 'SQUARE',
                        positionX: MediaQuery.of(context).size.width / 2.3,
                        positionY: MediaQuery.of(context).size.height / 2.5,
                        height: 50,
                        width: 50,
                        color: 0xffC4C4C4,
                        noteContentId: contentId,
                        borderColor: 0xffC4C4C4,
                        text: '',
                      ));
                },
                child: Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 3),
                  ),
                ),
              ),
              SizedBox(
                height: 48,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        FloatingActionButton(
          backgroundColor: AppColors.orange,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          child: Icon(
            Icons.home,
            color: AppColors.white,
          ),
        )
      ]),
    );
  }
}


// FloatingActionButton(
//               backgroundColor: AppColors.orange,
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => HomePage()));
//               },
//               child: Icon(
//                 Icons.home,
//                 color: AppColors.white,
//               ),
//             )