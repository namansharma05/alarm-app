import 'package:alarm_app/presentation/widgets/bottom_bar.dart';
import 'package:alarm_app/presentation/widgets/clock_body.dart';
import 'package:alarm_app/presentation/widgets/digital_clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  List<bool> _switchValues = [false, false, false, false];
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text("Alarm"),
      ),
      bottomNavigationBar: BottomBar(),
      body: Column(
        children: [
          ClockBody(),
          const SizedBox(
            height: 30,
          ),
          DigitalClock(),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: 4,
          //     itemBuilder: (context, index) {
          //       return Container(
          //         margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Column(
          //               children: [
          //                 Text("8:30 PM"),
          //                 const SizedBox(
          //                   height: 5,
          //                 ),
          //                 Text("subtitle")
          //               ],
          //             ),
          //             CupertinoSwitch(
          //                 value: _switchValues[index],
          //                 onChanged: (val) {
          //                   setState(() {
          //                     _switchValues[index] = val;
          //                   });
          //                 })
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
