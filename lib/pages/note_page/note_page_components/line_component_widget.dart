import 'package:flutter/material.dart';


class LineComponentWidget extends StatelessWidget {
  const LineComponentWidget({
    Key? key,
    required this.componentA,
    required this.componentB,
  }) : super(key: key);

  final Offset componentA;
  final Offset componentB;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: GestureDetector(
        onTap: () {
          print('tapped on line');
        },
        child: CustomPaint(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height),
          painter:
              CurvedPainter(componentA: componentA, componentB: componentB),
        ),
      ),
    );
  }
}

class CurvedPainter extends CustomPainter {
  final Offset componentA;
  final Offset componentB;
  CurvedPainter({required this.componentA, required this.componentB});
  var radius = 5.0;
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 15;

    var path = Path();
    path.lineTo(componentA.dx, componentA.dy);
    path.lineTo(componentB.dx, componentB.dy);
    path.lineTo(componentB.dx + 2, componentB.dy + 2);
    path.lineTo(componentA.dx + 2, componentA.dy + 2);
    path.lineTo(componentA.dx, componentA.dy);

    canvas.drawPath(path, paint);
    ;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
