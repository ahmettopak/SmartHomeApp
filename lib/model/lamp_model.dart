import 'dart:ffi';

class Lamp {
  final String name;
  final bool status;

  Lamp({
    required this.name,
    required this.status,
  });

  factory Lamp.fromJson(Map<String, dynamic> json) {
    return Lamp(
      name: json['name'],
      status: json['status'],
    );
  }
}
