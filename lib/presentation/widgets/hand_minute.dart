import 'dart:math' as math;

import 'package:flutter/material.dart';

class MinuteHandPainter extends CustomPainter {
  int? minutes;
  int? seconds;

  MinuteHandPainter({this.minutes, this.seconds});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    double radius = math.min(centerX, centerY);
    Offset center = Offset(centerX, centerY);

    canvas.save();

    // canvas.translate(radius, radius);

    Paint minuteLinePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    // Path path = new Path();
    // path.moveTo(-1.5, -radius - 10.0);
    // path.lineTo(-5.0, -radius / 1.8);
    // path.lineTo(-2.0, 10.0);
    // path.lineTo(2.0, 10.0);
    // path.lineTo(5.0, -radius / 1.8);
    // path.lineTo(1.5, -radius - 10.0);
    // path.close();
    Offset minEndOffset = Offset(
        centerX - radius * 0.6 * math.cos(minutes! * 6 * math.pi / 180),
        centerY - radius * 0.6 * math.sin(minutes! * 6 * math.pi / 180));

    // canvas.rotate(2 * math.pi * ((minutes! + (seconds! / 60)) / 60));
    canvas.drawLine(center, minEndOffset, minuteLinePaint);
    // canvas.drawPath(path, minuteHandPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(MinuteHandPainter oldDelegate) {
    return true;
  }
}
