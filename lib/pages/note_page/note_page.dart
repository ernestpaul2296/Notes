import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:surfwar_flutter/models/models.dart';
import 'package:surfwar_flutter/pages/note_page/view_model/note_page_viewmodel.dart';
import 'package:surfwar_flutter/services/global.dart';
import 'package:surfwar_flutter/services/notes.dart';

import 'note_page_components/note_page_components.dart';

class NotePage extends StatelessWidget {
  final String noteId;

  NotePage({required this.noteId});
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Focus.of(context).unfocus();
      },
      child: Scaffold(
        floatingActionButton: FloatingButtonWidget(),
        body: ChangeNotifierProvider(
          create: (_) => NotePageViewModel(noteId: noteId),
          child: NotePageBody(
            noteId: noteId,
          ),
        ),
      ),
    );
  }
}

class NotePageBody extends StatelessWidget {
  final String noteId;
  NotePageBody({required this.noteId});

  TransformationController _transformationController =
      TransformationController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (p0, isKeyboardVisible) {
      NotePageViewModel.of(context)
          .setValueForKeyboardVisibility(isKeyboardVisible);
      return ValueListenableBuilder(
        valueListenable: Global.boxes[BOX_NAME.NOTES_BOX]!.listenable(),
        builder: (context, Box box, wid) {
          Note note = box.get(noteId);

          List<Widget> widgetsToDisplay =
              NotePageViewModel(noteId: noteId).returnWidgetlist();

          if (note.transformationControllerValue != null) {
            _transformationController.value =
                Matrix4.fromList(note.transformationControllerValue!);
            note.transformationControllerValue!;
          }

          return Stack(
            children: [
              InteractiveViewer(
                transformationController: _transformationController,
                onInteractionUpdate: (details) {
                  Note note = Global.boxes[BOX_NAME.NOTES_BOX]!.get(noteId);

                  note.transformationControllerValue =
                      _transformationController.value.storage;

                  NotesService.saveNoteLocally(note);
                },
                minScale: 0.1,
                maxScale: 4,
                panEnabled: true,
                scaleEnabled: true,
                child: Stack(
                  children: widgetsToDisplay,
                ),
              ),
              ValueListenableBuilder<bool>(
                  valueListenable:
                      NotePageViewModel.of(context).isKeyBoardVisible,
                  builder: (context, isVisible, _) {
                    if (isVisible) {
                      return Positioned(
                          bottom: 0,
                          child: Container(
                            height: 50,
                            width: 300,
                            color: Colors.grey.shade300,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ValueListenableBuilder<String>(
                                      valueListenable:
                                          NotePageViewModel.of(context)
                                              .selectedComponent,
                                      builder: (context, selectedComponent, _) {
                                        return GestureDetector(
                                          onTap: () {
                                            // enabled == false
                                            //     ? NotePageViewModel.of(context)
                                            //         .setBoldEnable(true)
                                            NotePageViewModel.of(context)
                                                .setBoldEnable(
                                                    noteId, selectedComponent);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                border: Border.all(
                                                    color: Colors.transparent)),
                                            child: Text(
                                              'B',
                                              style: GoogleFonts.robotoSlab(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                  ValueListenableBuilder(
                                      valueListenable:
                                          NotePageViewModel.of(context)
                                              .isItalicEnable,
                                      builder: (context, italics, _) {
                                        return GestureDetector(
                                          onTap: () {
                                            italics == false
                                                ? NotePageViewModel.of(context)
                                                    .setItalicsEnable(true)
                                                : NotePageViewModel.of(context)
                                                    .setItalicsEnable(false);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12),
                                            decoration: BoxDecoration(
                                                color: italics == true
                                                    ? Colors.blue
                                                    : Colors.transparent,
                                                border: italics == true
                                                    ? Border.all()
                                                    : Border.all(
                                                        color: Colors
                                                            .transparent)),
                                            child: Text(
                                              'I',
                                              style: GoogleFonts.robotoSlab(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900,
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 22),
                                            ),
                                          ),
                                        );
                                      }),
                                  ValueListenableBuilder(
                                      valueListenable:
                                          NotePageViewModel.of(context)
                                              .isUnderlined,
                                      builder: (context, underlined, _) {
                                        return GestureDetector(
                                          onTap: () {
                                            underlined == false
                                                ? NotePageViewModel.of(context)
                                                    .setUnderline(true)
                                                : NotePageViewModel.of(context)
                                                    .setUnderline(false);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12),
                                            decoration: BoxDecoration(
                                                color: underlined == true
                                                    ? Colors.yellow
                                                    : Colors.transparent,
                                                border: underlined == true
                                                    ? Border.all()
                                                    : Border.all(
                                                        color: Colors
                                                            .transparent)),
                                            child: Text(
                                              'U',
                                              style: GoogleFonts.robotoSlab(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontSize: 22),
                                            ),
                                          ),
                                        );
                                      }),
                                ]),
                          ));
                    }
                    return SizedBox();
                  })
            ],
          );
        },
      );
    });
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
