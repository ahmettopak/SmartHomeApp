import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';

class PercentSensor extends StatelessWidget {
  final String sensorName;
  final num value;

  const PercentSensor({
    super.key,
    required this.sensorName,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 100,
            pointers: <GaugePointer>[
              MarkerPointer(
                value: value.toDouble(),
                animationType: AnimationType.linear,
                enableAnimation: true,
                markerWidth: 20,
                markerHeight: 20,
                markerOffset: -5,
                color: Colors.grey[800],
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Text(
                  "%$value",
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
                angle: 90,
                positionFactor: 1,
                verticalAlignment: GaugeAlignment.near,
              ),
            ],
            ticksPosition: ElementsPosition.inside,
            labelFormat: "%{value}",
            interval: 20,
            showLastLabel: true,
            axisLineStyle: const AxisLineStyle(
              thickness: 10,
            ),
          ),
        ],
        animationDuration: 1,
        enableLoadingAnimation: true,
        title: GaugeTitle(
            text: sensorName,
            textStyle:
                const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
