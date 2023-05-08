class Sensor {
  final String name;
  final num value;

  Sensor({
    required this.name,
    required this.value,
  });

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
      name: json['name'],
      value: json['value'],
    );
  }
}
