// ignore: camel_case_types
import 'package:flutter/material.dart';
import 'package:hackefx_ecosense/client/Widgets/humidityGauge.dart';
import 'package:hackefx_ecosense/client/Widgets/oilGauge.dart';
import 'package:hackefx_ecosense/client/Widgets/pressureGauge.dart';
import 'package:hackefx_ecosense/client/Widgets/smokeGauge.dart';
import 'package:hackefx_ecosense/client/Widgets/tempGauge.dart';
import 'package:hackefx_ecosense/client/Widgets/vibrationGauge.dart';
import 'package:hackefx_ecosense/client/Widgets/voltageGauge.dart';

// ignore: camel_case_types
class Custom_temp_gauge extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const Custom_temp_gauge({super.key, required this.Value});

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
// ignore: camel_case_types
class Custom_humidity_gauge extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const Custom_humidity_gauge({super.key, required this.Value});

  // ignore: non_constant_identifier_names
  final double Value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Humiditygauge(humidity: Value, intervel: 10, maximum: 100,),
    );
  }
}
// ignore: camel_case_types
class Custom__oil_gauge extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const Custom__oil_gauge({super.key, required this.Value});

  // ignore: non_constant_identifier_names
  final double Value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Oilgauge(oil: Value, intervel: 10, maximum: 100,),
    );
  }
}
// ignore: camel_case_types
class Custom__smoke_gauge extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const Custom__smoke_gauge({super.key, required this.Value});

  // ignore: non_constant_identifier_names
  final double Value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Smokegauge(smoke: Value, intervel: 10, maximum: 100,),
    );
  }
}
// ignore: camel_case_types
class Custom__vibration_gauge extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const Custom__vibration_gauge({super.key, required this.Value});

  // ignore: non_constant_identifier_names
  final double Value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Vibrationgauge(vibration: Value, intervel: 10, maximum: 100,),
    );
  }
}
// ignore: camel_case_types
class Custom__voltage_gauge extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const Custom__voltage_gauge({super.key, required this.Value});

  // ignore: non_constant_identifier_names
  final double Value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Voltagegauge(voltage: Value, intervel: 10, maximum: 100,),
    );
  }
}
class Custom_pressure_gauge extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const Custom_pressure_gauge({super.key, required this.Value});

  // ignore: non_constant_identifier_names
  final double Value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Pressuregauge(preasure: Value, intervel: 10, maximum: 100,),
    );
  }
}