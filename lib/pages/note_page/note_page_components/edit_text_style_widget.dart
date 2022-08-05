



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../view_model/note_page_viewmodel.dart';

class EditTextStyleWidget extends StatelessWidget {
  const EditTextStyleWidget({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  final String noteId;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable:
            NotePageViewModel.of(context).isKeyBoardVisible,
        builder: (context, isVisible, _) {
          if (isVisible) {
            return  ValueListenableBuilder<String>(
             valueListenable:NotePageViewModel.of(context).selectedComponent,
              builder: (context, selectedComponent, _) {
                return Positioned(
                    bottom: 0,
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xffD2D3D8),
                      child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                          children: [
                           
                                   GestureDetector(
                                    onTap: () {
                                     
                                      NotePageViewModel.of(context)
                                          .setBoldEnable(
                                              noteId, selectedComponent);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                          color:  Colors.transparent,
                                          border: Border.all(
                                              color: Colors.transparent),
                                              boxShadow: [
                                                if(NotePageViewModel.of(context).checkBoldEnabled(selectedComponent))
                                                BoxShadow(color: Colors.black,
                                                blurStyle: BlurStyle.outer,
                                                offset: Offset(0,0),
                                                blurRadius: 2,

                                                )
                                              ]
                                              ),
                                              
                                      child: Text(
                                        'B',
                                        style: GoogleFonts.robotoSlab(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ),

                            GestureDetector(
                                    onTap: () {

                                      NotePageViewModel.of(context).setItalicsEnable(noteId, selectedComponent);
                                         
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12),
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,

                                          border: Border.all(
                                                  color: Colors
                                                      .transparent),
                                                       boxShadow: [
                                                if(NotePageViewModel.of(context).checkItalicsEnabled(selectedComponent))
                                                BoxShadow(color: Colors.black,

                                                blurStyle: BlurStyle.outer,
                                                offset: Offset(0,0),
                                                
                                                blurRadius: 2,

                                                )
                                              ]),
                                      child: Text(
                                        'I',
                                        style: GoogleFonts.robotoSlab(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 22),
                                      ),
                                    ),
                                  ),

                            GestureDetector(
                                    onTap: () {
                                      NotePageViewModel.of(context)
                                              .setUnderline(noteId, selectedComponent);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12),
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                                  color: Colors
                                                      .transparent),
                                                      
                                                            boxShadow: [
                                                if(NotePageViewModel.of(context).checkUnderLineEnabled(selectedComponent))
                                                BoxShadow(color: Colors.black,

                                                blurStyle: BlurStyle.outer,
                                                offset: Offset(0,0),
                                                
                                                blurRadius: 2,

                                                )
                                              ]),
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
                                  ),

                          ]),
                    ));
              }
            );
          }
          return SizedBox();
        });
  }
}
