import 'dart:math' as math;

import 'package:flutter/material.dart';

class SecondHandPainter extends CustomPainter {
  int? seconds;

  SecondHandPainter({this.seconds});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    double radius = math.min(centerX, centerY);
    Offset center = Offset(centerX, centerY);

    canvas.save();

    Paint secondHandPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    Offset secEndOffset = Offset(
        centerX + radius * math.cos((seconds! * 6 - 90) * math.pi / 180),
        centerY + radius * math.sin((seconds! * 6 - 90) * math.pi / 180));

    // canvas.translate(centerX, centerX);

    // canvas.rotate(2 * math.pi * seconds! / 60);

    canvas.drawLine(center, secEndOffset, secondHandPaint);
    // canvas.drawPath(path1, secondHandPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(SecondHandPainter oldDelegate) {
    return this.seconds != oldDelegate.seconds;
  }
}
