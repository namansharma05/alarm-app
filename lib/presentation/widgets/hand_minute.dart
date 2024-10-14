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

    Offset minEndOffset = Offset(
        centerX +
            radius *
                .8 *
                math.cos((minutes! * 6 + seconds! * 0.1 - 90) * math.pi / 180),
        centerY +
            radius *
                .8 *
                math.sin((minutes! * 6 + seconds! * 0.1 - 90) * math.pi / 180));

    canvas.drawLine(center, minEndOffset, minuteLinePaint);
    // canvas.drawPath(path, minuteHandPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(MinuteHandPainter oldDelegate) {
    return true;
  }
}
