import 'package:alarm_app/presentation/widgets/clock_hands.dart';
import 'package:flutter/material.dart';

class ClockBody extends StatelessWidget {
  const ClockBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        height: 300,
        width: 300,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white,
                Colors.grey,
                Colors.black12,
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15,
                spreadRadius: 5,
                offset: Offset(10.0, 10.0),
              ),
            ],
            borderRadius: BorderRadius.circular(150)),
        child: new Stack(
          children: <Widget>[
            //dial and numbers go here
            Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(10.0),
              child: ClockHands(),
              // child: new CustomPaint(
              //   painter: new ClockDialPainter(clockText: ClockText.roman),
              // ),
            ),
            //centerpoint
            // CustomPaint(
            //   painter: ClockDialPainter(clockText: ClockText.roman),
            // ),
            new Center(
              child: new Container(
                width: 10.0,
                height: 10.0,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black,
                ),
                // child: ClockHands(),
              ),
            ),
            //clock hands go here
          ],
        ),
      ),
    );
  }
}
