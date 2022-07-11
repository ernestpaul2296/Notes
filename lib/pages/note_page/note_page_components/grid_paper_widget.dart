import 'package:flutter/material.dart';

import '../../../models/note_content.dart';
import '../../../services/notes.dart';
import '../../../services/utils.dart';
import '../note_page.dart';

class GridPaperWidget extends StatelessWidget {
  GridPaperWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final NotePage widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: GestureDetector(
        onDoubleTap: () {},
        onTapUp: ((details) {
          String contentId = Utils.getSecureString(20);
          print('On double tap down');
          print(TapDownDetails().globalPosition.dx);
          print(TapDownDetails().localPosition.dy);

          NotesService.addNoteContent(
              widget.id,
              NoteContent(
                  connectedComponents: [],
                  fontSize: 12,
                  noteContentType: 'TEXT',
                  positionX: details.localPosition.dx,
                  positionY: details.localPosition.dy,
                  height: 100,
                  width: 100,
                  color: 0xff828282,
                  noteContentId: contentId,
                  borderColor: 0xff828282,
                  text: ''));
        }),
        child: GridPaper(
          color: Colors.transparent,
          child: Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }
}
