import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smarthomeui/model/sensor_model.dart';
import 'package:smarthomeui/util/percent_sensor.dart';
import '../api/fetch_sensor.dart';
import '../constants/constants.dart';

class SensorPage extends StatefulWidget {
  const SensorPage({super.key});

  @override
  State<SensorPage> createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  List<Sensor> sensor = [];
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _fetchSensor();
    _startTimer();
    // try {
    //   Timer.periodic(const Duration(seconds: 30), (timer) {

    //   });
    // } catch (e) {}
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) {
        setState(() {
          _fetchSensor();
          Fluttertoast.showToast(
            msg: "Sensor data refresh",
          );
        });
      } else {
        _stopTimer();
      }
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  List mySensors = [
    ["Humidity", 35],
    ["Tempture", 20],
    ["Light", 50],
  ];

  Future<void> _fetchSensor() async {
    final fetchedSensor = await fetchSensor();
    setState(() {
      sensor = fetchedSensor;
      // Fluttertoast.showToast(
      //   msg: lamp.length.toString(),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // app bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // menu icon
                  Image.asset(
                    'lib/icons/menu.png',
                    height: 45,
                    color: Colors.grey[800],
                  ),
                  // account icon
                  Icon(
                    Icons.person,
                    size: 45,
                    color: Colors.grey[800],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            // smart devices grid
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                "Sensor",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.grey.shade800,
                ),
              ),
            ),

            Expanded(
              child: GridView.builder(
                itemCount: sensor.length,
                physics: const ScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: horizontalPadding),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.4,
                ),
                itemBuilder: (context, index) {
                  return PercentSensor(
                    sensorName: sensor[index].name,
                    value: sensor[index].value,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
