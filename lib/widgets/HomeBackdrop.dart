import 'package:flutter/material.dart';

class HomeBackdrop extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width - 60, 0);
    canvas.drawCircle(
        center, 210, Paint()..color = Colors.green[500].withOpacity(.4));
    canvas.drawCircle(center.translate(-size.width / 1.2, size.width * 1.2),
        150, Paint()..color = Colors.green.withOpacity(.2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}