// ignore: camel_case_types
import 'package:flutter/material.dart';
import 'package:hackefx_ecosense/client/Widgets/tempGauge.dart';

// ignore: camel_case_types
class Custom_gauge extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const Custom_gauge({super.key, required this.Value});

  // ignore: non_constant_identifier_names
  final double Value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: TemperatureGauge(temperature: Value, intervel: 10, maximum: 100,),
    );
  }
}