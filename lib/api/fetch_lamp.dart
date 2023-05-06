import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smarthomeui/constants/constants.dart';
import 'package:smarthomeui/model/lamp_model.dart';

Future<List<Lamp>> fetchLamp() async {
  final response = await http.get(Uri.parse(lampGetUrl));
  if (response.statusCode == 200) {
    final jsonList = json.decode(response.body) as List<dynamic>;
    return jsonList.map((json) => Lamp.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch lamp');
  }
}

List<Lamp> smartDevicesFromJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return List<Lamp>.from(jsonData.map((json) => Lamp.fromJson(json)));
}
