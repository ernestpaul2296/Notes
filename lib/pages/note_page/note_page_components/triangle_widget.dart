import 'package:flutter/material.dart';
import 'dart:math' as math;

class TriangleWidget extends StatelessWidget {
  double height;
  double width;
  Color color;

  TriangleWidget({
    required this.color,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ShapesPainter(color),
      child: Container(
        height: height,
        width: width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 16),
            child: Transform.rotate(
              angle: math.pi / 4,
            ),
          ),
        ),
      ),
    );
  }
}

class ShapesPainter extends CustomPainter {
  final Color color;
  ShapesPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color;
    var path = Path();
    path.lineTo(size.width / 2, 0);
    // path.lineTo(size.width, 0);
    path.lineTo(size.height, size.width);
    path.lineTo(0, size.width);
    path.lineTo(size.width / 2, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
