import 'dart:math' as math;

import 'package:flutter/material.dart';

class HourHandPainter extends CustomPainter {
  final int? hours;
  final int? minutes;

  HourHandPainter({this.hours, this.minutes});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    double radius = math.min(centerX, centerY);
    Offset center = Offset(centerX, centerY);
    // To draw hour hand
    canvas.save();

    // canvas.translate(radius, radius);

    Paint hourLinePint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    Offset hrsEndOffset = Offset(
        centerX - radius * 0.4 * math.cos(hours! * 6 * math.pi / 180),
        centerY - radius * 0.4 * math.sin(hours! * 6 * math.pi / 180));

    //checks if hour is greater than 12 before calculating rotation
    // canvas.rotate(hours! >= 12
    //     ? 2 * math.pi * ((hours! - 12) / 12 + (minutes! / 720))
    //     : 2 * math.pi * ((hours! / 12) + (minutes! / 720)));

    canvas.drawLine(center, hrsEndOffset, hourLinePint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(HourHandPainter oldDelegate) {
    return true;
  }
}
