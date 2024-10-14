import 'dart:async';

import 'package:alarm_app/presentation/widgets/clock_tick_painter.dart';
import 'package:alarm_app/presentation/widgets/hand_hour.dart';
import 'package:alarm_app/presentation/widgets/hand_minute.dart';
import 'package:alarm_app/presentation/widgets/hand_second.dart';
import 'package:flutter/material.dart';

class ClockHands extends StatefulWidget {
  @override
  _ClockHandState createState() => new _ClockHandState();
}

class _ClockHandState extends State<ClockHands> {
  late Timer _timer;
  late DateTime dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = new DateTime.now();
    _timer = new Timer.periodic(const Duration(seconds: 1), setTime);
  }

  void setTime(Timer timer) {
    setState(() {
      dateTime = new DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(_timer);
    // print(dateTime);
    return new Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      child: new Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: ClockDialPainter(clockText: ClockText.roman),
          ),
          new CustomPaint(
            painter: new SecondHandPainter(
              seconds: dateTime.second,
            ),
          ),
          new CustomPaint(
            painter: new MinuteHandPainter(
                seconds: dateTime.second, minutes: dateTime.minute),
          ),
          new CustomPaint(
            painter: new HourHandPainter(
                hours: dateTime.hour, minutes: dateTime.minute),
          ),
        ],
      ),
    );
  }
}
