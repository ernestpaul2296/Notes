import 'package:flutter/material.dart';
import 'package:surfwar_flutter/models/note_content.dart';
import 'package:surfwar_flutter/pages/pages.dart';
import 'package:surfwar_flutter/services/notes.dart';
import 'package:surfwar_flutter/services/utils.dart';
import 'package:surfwar_flutter/styles/styles.dart';

class NotePageButtons extends StatelessWidget {
  const NotePageButtons({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          // backgroundColor: AppColors.white,
          onPressed: () {
            String contentId = Utils.getSecureString(20);
            NotesService.addNoteContent(
                id,
                NoteContent(
                    fontSize: 18,
                    noteContentType: 'HORIZONTAL_LINE',
                    positionX: MediaQuery.of(context).size.width / 2,
                    positionY: MediaQuery.of(context).size.height / 2,
                    height: 4,
                    width: 100,
                    color: 0xff828282,
                    noteContentId: contentId,
                    borderColor: 0xff828282,
                    text: ''));
          },
          child: Container(
            height: 3,
            width: 48,
            color: Colors.black,
          ),
        ),
        TextButton(
          // backgroundColor: AppColors.white,
          onPressed: () {
            String contentId = Utils.getSecureString(20);
            NotesService.addNoteContent(
                id,
                NoteContent(
                    fontSize: 18,
                    noteContentType: 'VERTICAL_LINE',
                    positionX: MediaQuery.of(context).size.width / 2,
                    positionY: MediaQuery.of(context).size.height / 2,
                    height: 100,
                    width: 4,
                    color: 0xff828282,
                    noteContentId: contentId,
                    borderColor: 0xff828282,
                    text: ''));
          },
          child: Text(
            '|',
            style: AppFonts.primaryHeader,
          ),
        ),
        TextButton(
          // backgroundColor: AppColors.white,
          onPressed: () {
            String contentId = Utils.getSecureString(20);
            NotesService.addNoteContent(
                id,
                NoteContent(
                    fontSize: 18,
                    noteContentType: 'TEXT',
                    positionX: MediaQuery.of(context).size.width / 2,
                    positionY: MediaQuery.of(context).size.height / 2,
                    height: 100,
                    width: 100,
                    color: 0xff828282,
                    noteContentId: contentId,
                    borderColor: 0xff828282,
                    text: 'Edit Text'));
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
                id,
                NoteContent(
                  noteContentType: 'DIAMOND',
                  positionX: MediaQuery.of(context).size.width / 2,
                  positionY: MediaQuery.of(context).size.height / 2,
                  height: 100,
                  width: 100,
                  color: 0xff828282,
                  noteContentId: contentId,
                  borderColor: 0xff828282,
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
                  id,
                  NoteContent(
                    noteContentType: 'CIRCLE',
                    positionX: MediaQuery.of(context).size.width / 2,
                    positionY: MediaQuery.of(context).size.height / 2,
                    height: 100,
                    width: 100,
                    color: 0xff828282,
                    noteContentId: contentId,
                    borderColor: 0xff828282,
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
        TextButton(
            //  backgroundColor: AppColors.white,
            onPressed: () {
              String contentId = Utils.getSecureString(20);
              NotesService.addNoteContent(
                  id,
                  NoteContent(
                    noteContentType: 'TRIANGLE',
                    positionX: MediaQuery.of(context).size.width / 2,
                    positionY: MediaQuery.of(context).size.height / 2,
                    height: 100,
                    width: 100,
                    color: 0xff828282,
                    noteContentId: contentId,
                    borderColor: 0xff828282,
                    text: '',
                  ));
            },
            child: Icon(
              Icons.landscape_outlined,
              color: AppColors.black,
              size: 36,
            )),
        SizedBox(
          height: 24,
        ),
        TextButton(
          // backgroundColor: AppColors.white,
          onPressed: () {
            String contentId = Utils.getSecureString(20);
            NotesService.addNoteContent(
                id,
                NoteContent(
                  noteContentType: 'CONTAINER',
                  positionX: MediaQuery.of(context).size.width / 2,
                  positionY: MediaQuery.of(context).size.height / 2,
                  height: 200,
                  width: 100,
                  color: 0xff828282,
                  noteContentId: contentId,
                  borderColor: 0xff828282,
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
                id,
                NoteContent(
                  noteContentType: 'SQUARE',
                  positionX: MediaQuery.of(context).size.width / 2,
                  positionY: MediaQuery.of(context).size.height / 2,
                  height: 100,
                  width: 100,
                  color: 0xff828282,
                  noteContentId: contentId,
                  borderColor: 0xff828282,
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
      ],
    );
  }
}
