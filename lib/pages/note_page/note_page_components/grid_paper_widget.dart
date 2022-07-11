import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../models/note_content.dart';
import '../../../services/notes.dart';
import '../../../services/utils.dart';

class GridPaperWidget extends StatelessWidget {
  const GridPaperWidget({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  final String noteId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: GestureDetector(
        onDoubleTap: () {
          TapUpDetails details = TapUpDetails(kind: PointerDeviceKind.unknown);
          print(details.globalPosition.dx);
          print(details.globalPosition.dy);
        },
        onTapUp: ((details) {
          String contentId = Utils.getSecureString(20);
          print('On double tap down');

          NotesService.addNoteContent(
              noteId,
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
                  data: ''));
        }),
        child: GridPaper(
          color: Colors.grey,
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
