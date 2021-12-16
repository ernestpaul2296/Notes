import 'package:flutter/material.dart';
import 'package:surfwar_flutter/models/note.dart';
import 'package:surfwar_flutter/pages/pages.dart';
import 'package:surfwar_flutter/styles/styles.dart';

class NotesWidgetsComponent extends StatelessWidget {
  const NotesWidgetsComponent({
    Key? key,
    required this.notes,
  }) : super(key: key);

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        itemCount: notes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotePage(id: notes[index].id)));
            },
            child: Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.only(top: 6, left: 6, right: 6, bottom: 6),
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
                  Text(
                    'Created on: ${notes[index].createdOn.day}-${notes[index].createdOn.month}- ${notes[index].createdOn.year}',
                    style: AppFonts.noteTime,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
