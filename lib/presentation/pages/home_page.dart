import 'package:alarm_app/presentation/bloc/alarm_bloc.dart';
import 'package:alarm_app/presentation/bloc/alarm_state.dart';
import 'package:alarm_app/presentation/widgets/bottom_bar.dart';
import 'package:alarm_app/presentation/widgets/clock_body.dart';
import 'package:alarm_app/presentation/widgets/digital_clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text("Alarm"),
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 10,
              spreadRadius: 15,
            )
          ]),
          child: BottomBar()),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            ClockBody(),
            const SizedBox(
              height: 30,
            ),
            DigitalClock(),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: BlocBuilder<AlarmBloc, AlarmState>(
                builder: (context, state) {
                  if (state is AlarmLoadingState) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  } else if (state is AlarmLoadedState) {
                    final alarms = state.alarms; // Handle potential null case
                    if (alarms == null || alarms.isEmpty) {
                      return const Center(child: Text("No alarms"));
                    }
                    return ListView.builder(
                      itemCount: state.alarms!.length,
                      itemBuilder: (context, index) {
                        final alarm = state.alarms![index];
                        final hour = alarm.hour.toString().padLeft(2, '0');
                        final minute = alarm.minute.toString().padLeft(2, '0');
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          child: ListTile(
                            tileColor: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: Text(
                              "$hour:$minute  ${alarm.meridiem}",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            trailing: CupertinoSwitch(
                              value: alarm.status!,
                              onChanged: (val) {
                                // setState(() {
                                //   value = val;
                                // });
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is AlarmErrorState) {
                    return Center(
                      child: Text(state.error!),
                    );
                  } else {
                    return const Center(
                      child: Text("No alarms"),
                    );
                  }
                },
              ),
            ),
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
      ),
    );
  }
}
