import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DigitalClock extends StatefulWidget {
  const DigitalClock({super.key});

  @override
  State<DigitalClock> createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime dateTime = DateTime.now();
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), setTime);
    super.initState();
  }

  void setTime(Timer timer) {
    setState(() {
      dateTime = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "0${dateTime.hour % 12}:",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 70),
          ),
          Text(
            dateTime.minute < 10 ? "0${dateTime.minute}" : "${dateTime.minute}",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 70),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            dateTime.hour < 12 ? "AM" : "PM",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 70),
          ),
        ],
      ),
    );
  }
}
