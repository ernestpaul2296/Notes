import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surfwar_flutter/pages/note_page/view_model/note_page_viewmodel.dart';
import 'note_page_components/note_page_body.dart';
import 'note_page_components/note_page_components.dart';





class NotePage extends StatelessWidget {
  final String noteId;

  NotePage({required this.noteId});
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Focus.of(context).unfocus();
      },
      child: 
       ChangeNotifierProvider(
          create: (_) => NotePageViewModel(noteId: noteId),
          child: Scaffold(
             floatingActionButton: FloatingButtonWidget(),
            body: NotePageBody(
              noteId: noteId,
            ),
          ),
        ),

    );
  }
}



















































// note.noteContent.forEach((e) {
//   e.connectedComponents.forEach((element) {
//     NoteContent connectedToComponent = noteContents
//         .firstWhere((el) => el.noteContentId == element);

//     widgetsToDisplay.add(LineComponentWidget(
//       componentA: Offset(e.positionX, e.positionY),
//       componentB: Offset(connectedToComponent.positionX,
//           connectedToComponent.positionY),
//     ));
//   });
// });
// widgetsToDisplay.add(GridPaperWidget(noteId: noteId));
// note.noteContent.forEach((e) {
//   switch (e.noteContentType) {
//     case 'TEXT':
//       TextEditingController textController =
//           TextEditingController(text: e.data);
//       widgetsToDisplay.add(TextComponentWidget(
//         e: e,
//         id: widget.id,
//       ));
//       return;
//   }
// });
