import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:surfwar_flutter/models/note.dart';
import 'dart:math' as math;

import 'package:surfwar_flutter/models/note_content.dart';
import 'package:surfwar_flutter/services/global.dart';
import 'package:surfwar_flutter/services/notes.dart';
import 'package:surfwar_flutter/services/utils.dart';
import 'package:dotted_line/dotted_line.dart';

class LineWidget extends StatefulWidget {
  double startPointX;
  double endPointX;
  double startPointY;
  double endPointY;
  double controlPointX;
  double controlPointY;
  double centreX;
  double centreY;
  NoteContent e;
  String id;

  LineWidget(
      {required this.endPointX,
      required this.e,
      required this.id,
      required this.centreX,
      required this.centreY,
      required this.controlPointX,
      required this.controlPointY,
      required this.endPointY,
      required this.startPointX,
      required this.startPointY});

  @override
  State<LineWidget> createState() => _LineWidgetState();
}

class _LineWidgetState extends State<LineWidget> {
  onTapDown(TapDownDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    print(details.localPosition);
    print("tap down " + x.toString() + ", " + y.toString());
  }

  onTapUp(TapUpDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    print(details.localPosition);
    print("tap up " + x.toString() + ", " + y.toString());
  }

  Stream<CentrePositionData> stream =
      CurvePainter.centercontroller as Stream<CentrePositionData>;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        left: 0,
        top: 0,
        bottom: MediaQuery.of(context).size.height,
        right: MediaQuery.of(context).size.width,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.blue.withOpacity(0.3),
          child: CustomPaint(
            painter: CurvePainter(
                startPointX: widget.startPointX,
                startPointY: widget.startPointY,
                endPointX: widget.endPointX,
                endPointY: widget.endPointY,
                controlPointX: widget.controlPointX,
                controlPointY: widget.controlPointY),
          ),
        ),
      ),
      // Positioned(
      //   left: widget.startPointX,
      //   top: widget.startPointY,
      //   child: Transform.rotate(
      //     alignment: Alignment.topLeft,
      //     angle: math.atan2(widget.endPointY - widget.startPointY,
      //         widget.endPointX - widget.startPointX),
      //     child: Container(
      //       color: Colors.black,
      //       height: 2,
      //       width: widget.endPointX > widget.startPointX
      //           ? widget.endPointX - widget.startPointX
      //           : widget.endPointX - widget.startPointX,
      //     ),
      //   ),
      // ),
      Positioned(
        left: widget.startPointX - 18,
        top: widget.startPointY - 18,
        child: Draggable(
          onDragUpdate: (DragUpdateDetails details) {
            setState(() {
              widget.startPointX = details.globalPosition.dx;
              widget.startPointY = details.globalPosition.dy;
            });
          },
          onDragStarted: () {},
          onDragCompleted: () {
            String contentId = Utils.getSecureString(20);
            Note note = Global.boxes[BOX_NAME.NOTES_BOX]!.get(widget.id);
            note.noteContent.removeWhere(
                (element) => element.noteContentId == widget.e.noteContentId);

            note.noteContent.add(
              NoteContent(
                noteContentType: 'LINE',
                positionX: widget.startPointX,
                positionY: widget.startPointY,
                height: 0,
                width: 0,
                color: 11221122,
                noteContentId: contentId,
                borderColor: 112211,
                endPointX: widget.endPointX,
                centreX: widget.centreX,
                centreY: widget.centreY,
                controlPointX: widget.controlPointX,
                controlPointY: widget.controlPointY,
                endPointY: widget.endPointY,
                startPointX: widget.startPointX,
                startPointY: widget.startPointY,
              ),
            );
            NotesService.saveNoteLocally(note);
          },
          onDragEnd: (DraggableDetails details) {
            String contentId = Utils.getSecureString(20);
            Note note = Global.boxes[BOX_NAME.NOTES_BOX]!.get(widget.id);
            note.noteContent.removeWhere(
                (element) => element.noteContentId == widget.e.noteContentId);
            print('note content removed');

            note.noteContent.add(
              NoteContent(
                noteContentType: 'LINE',
                positionX: widget.startPointX,
                positionY: widget.startPointY,
                height: 0,
                fontSize: 2,
                width: 0,
                color: 11221122,
                noteContentId: contentId,
                borderColor: 112211,
                endPointX: widget.endPointX,
                centreX: widget.centreX,
                centreY: widget.centreY,
                controlPointX: widget.controlPointX,
                controlPointY: widget.controlPointY,
                endPointY: widget.endPointY,
                startPointX: widget.startPointX,
                startPointY: widget.startPointY,
              ),
            );
            print('note content added');
            NotesService.saveNoteLocally(note);
          },
          data: {},
          dragAnchorStrategy: pointerDragAnchorStrategy,
          feedback: Container(
            color: Colors.transparent,
            width: 30,
            height: 30,
          ),
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.all(12),
            child: Icon(
              Icons.circle_rounded,
              color: Colors.black,
              size: 12,
            ),
          ),
        ),
      ),
      Positioned(
        left: widget.endPointX - 22,
        top: widget.endPointY - 23,
        child: Draggable(
          onDragUpdate: (DragUpdateDetails details) {
            widget.endPointX = details.globalPosition.dx;
            widget.endPointY = details.globalPosition.dy;
            setState(() {
              widget.endPointX = details.globalPosition.dx;
              widget.endPointY = details.globalPosition.dy;
            });
          },
          onDragStarted: () {},
          onDragCompleted: () {},
          onDragEnd: (DraggableDetails details) {
            String contentId = Utils.getSecureString(20);
            Note note = Global.boxes[BOX_NAME.NOTES_BOX]!.get(widget.id);
            note.noteContent.removeWhere(
                (element) => element.noteContentId == widget.e.noteContentId);
            print('note content removed');

            note.noteContent.add(
              NoteContent(
                noteContentType: 'LINE',
                positionX: widget.startPointX,
                positionY: widget.startPointY,
                height: 0,
                width: 0,
                color: 11221122,
                noteContentId: contentId,
                borderColor: 112211,
                endPointX: widget.endPointX,
                centreX: widget.centreX,
                centreY: widget.centreY,
                controlPointX: widget.controlPointX,
                controlPointY: widget.controlPointY,
                endPointY: widget.endPointY,
                startPointX: widget.startPointX,
                startPointY: widget.startPointY,
              ),
            );
            print('note content added');
            NotesService.saveNoteLocally(note);
          },
          data: {},
          dragAnchorStrategy: pointerDragAnchorStrategy,
          feedback: Container(
            color: Colors.transparent,
            width: 30,
            height: 30,
          ),
          child: Transform.rotate(
            angle: math.atan2(widget.endPointY - widget.startPointY,
                widget.endPointX - widget.startPointX),
            child: Icon(
              Icons.arrow_right,
              color: Colors.black,
              size: 48,
            ),
          ),
        ),
      ),
      StreamBuilder<CentrePositionData>(
        stream: stream,
        builder: (
          BuildContext context,
          AsyncSnapshot<CentrePositionData> snapshot,
        ) {
          if (snapshot.hasData) {
            widget.centreX = snapshot.data!.centreX;
            widget.centreY = snapshot.data!.centreY;
            return Positioned(
              left: snapshot.data!.centreX - 8,
              top: snapshot.data!.centreY - 8,
              child: Draggable(
                onDragUpdate: (DragUpdateDetails details) {
                  widget.controlPointX = details.globalPosition.dx;
                  widget.controlPointY = details.globalPosition.dy;
                  setState(() {
                    widget.controlPointX = details.globalPosition.dx;
                    widget.controlPointY = details.globalPosition.dy;
                  });
                },
                onDragStarted: () {},
                onDragCompleted: () {},
                onDragEnd: (DraggableDetails details) {
                  String contentId = Utils.getSecureString(20);
                  Note note = Global.boxes[BOX_NAME.NOTES_BOX]!.get(widget.id);
                  note.noteContent.removeWhere((element) =>
                      element.noteContentId == widget.e.noteContentId);
                  print('note content removed');

                  note.noteContent.add(
                    NoteContent(
                      noteContentType: 'LINE',
                      positionX: widget.startPointX,
                      positionY: widget.startPointY,
                      height: 0,
                      width: 0,
                      color: 11221122,
                      noteContentId: contentId,
                      borderColor: 112211,
                      endPointX: widget.endPointX,
                      centreX: widget.centreX,
                      centreY: widget.centreY,
                      controlPointX: widget.controlPointX,
                      controlPointY: widget.controlPointY,
                      endPointY: widget.endPointY,
                      startPointX: widget.startPointX,
                      startPointY: widget.startPointY,
                    ),
                  );
                  print('note content added');
                  NotesService.saveNoteLocally(note);
                },
                data: {},
                dragAnchorStrategy: pointerDragAnchorStrategy,
                feedback: Container(
                  color: Colors.transparent,
                  width: 30,
                  height: 30,
                ),
                child: Icon(
                  Icons.circle_rounded,
                  color: Colors.transparent,
                ),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    ]);
  }
}

class CurvePainter extends CustomPainter {
  double startPointX;
  double endPointX;
  double startPointY;
  double endPointY;
  double controlPointX;
  double controlPointY;
  CurvePainter(
      {required this.endPointX,
      required this.controlPointX,
      required this.controlPointY,
      required this.endPointY,
      required this.startPointX,
      required this.startPointY});

  static StreamController<CentrePositionData> centerController =
      StreamController<CentrePositionData>.broadcast();
  static Stream get centercontroller => centerController.stream;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.black;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(startPointX, startPointY);

    //path.quadraticBezierTo(controlPointX, controlPointY, endPointX, endPointY);
    path.lineTo(endPointX, endPointY);
    double x = path.getBounds().center.dx;
    double y = path.getBounds().center.dy;

    centerController.add(CentrePositionData(centreX: x, centreY: y));

    path.lineTo(endPointX + 1, endPointY + 1);

    // path.quadraticBezierTo(
    //   controlPointX + 2, controlPointY, startPointX + 2, startPointY + 2);
    path.lineTo(startPointX + 1, startPointY + 1);
    path.lineTo(startPointX, startPointY);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CentrePositionData {
  double centreX;
  double centreY;
  CentrePositionData({
    required this.centreX,
    required this.centreY,
  });
}


  // @override
  // void paint(Canvas canvas, Size size) {
  //   var paint = Paint();
  //   paint.color = Colors.red;
  //   paint.style = PaintingStyle.fill; 

  //   var path = Path();

  //   path.moveTo(startPointX, startPointY);
  //   path.quadraticBezierTo(controlPointX, controlPointY, endPointX, endPointY);
  //   double x = path.getBounds().center.dx;
  //   double y = path.getBounds().center.dy;

  //   centerController.add(CentrePositionData(centreX: x, centreY: y));

  //   print(x);
  //   print(y);
  //   path.lineTo(endPointX + 2, endPointY + 2);

  //   path.quadraticBezierTo(
  //       controlPointX + 2, controlPointY, startPointX + 2, startPointY + 2);
  //   path.lineTo(startPointX, startPointY);

  //   canvas.drawPath(path, paint);
  // }