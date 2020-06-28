import 'package:flutter/material.dart';

class topDesign extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width - 40, 0);
    canvas.drawCircle(center, 200, Paint()..color = Colors.green[500].withOpacity(.4));
    canvas.drawCircle(center.translate(80, 200), 150, Paint()..color = Colors.green.withOpacity(.7));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}