import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:smarthomeui/constants/constants.dart';
import 'package:smarthomeui/model/lamp_model.dart';
import 'package:smarthomeui/model/sensor_model.dart';

Future<List<Sensor>> fetchSensor() async {
  try {
    final response = await http.get(Uri.parse(sensorGetUrl));
    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body) as List<dynamic>;
      return jsonList.map((json) => Sensor.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch sensor');
    }
  } catch (e) {
    throw const Text('Failed to fetch sensor');
  }
}

List<Sensor> smartDevicesFromJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return List<Sensor>.from(jsonData.map((json) => Lamp.fromJson(json)));
}
