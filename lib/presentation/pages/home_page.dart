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
                      return ListTile(
                        title: Text(
                            "${alarm.hour}:${alarm.minute}  ${alarm.meridiem}"),
                        trailing: CupertinoSwitch(
                          value: alarm.status!,
                          onChanged: (val) {
                            // setState(() {
                            //   value = val;
                            // });
                          },
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
    );
  }
}
