import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:surfwar_flutter/models/note.dart';
import 'package:surfwar_flutter/pages/pages.dart';
import 'package:surfwar_flutter/services/global.dart';
import 'package:surfwar_flutter/services/notes.dart';
import 'package:surfwar_flutter/styles/styles.dart';

class NotesWidgetsComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder(
          valueListenable: Global.boxes[BOX_NAME.NOTES_BOX]!.listenable(),
          builder: (context, Box box, wid) {
            List<Note> notes = List<Note>.from(box.values);
            return GridView.builder(
              itemCount: notes.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NotePage(noteId: notes[index].id)));
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin:
                        EdgeInsets.only(top: 6, left: 6, right: 6, bottom: 6),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.grey,
                              blurRadius: 15,
                              offset: Offset(
                                10,
                                10,
                              )),
                        ],
                        color: AppColors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 100,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notes[index].title,
                          style: AppFonts.noteTitle,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          notes[index].description,
                          style: AppFonts.noteSubTitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              'Created on: ${notes[index].createdOn.day}-${notes[index].createdOn.month}- ${notes[index].createdOn.year}',
                              style: AppFonts.noteTime,
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                NotesService()
                                    .deleteNoteLocally(notes[index].id);
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
