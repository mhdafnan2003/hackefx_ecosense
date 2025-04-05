import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Voltagegauge extends StatelessWidget {
  final double voltage;
  final double intervel,maximum;


  const Voltagegauge({super.key, required this.voltage, required this.intervel, required this.maximum});

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      animationDuration: 2000,
      enableLoadingAnimation: true,
      // title: const GaugeTitle(
      //   text: 'TEMPERATURE',
      //   textStyle: TextStyle(
      //     fontSize: 18,
      //     fontWeight: FontWeight.bold,
      //     color: Colors.black54,
      //   ),
      // ),
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: maximum,
          interval: intervel,
          radiusFactor: 0.9,
          axisLineStyle: const AxisLineStyle(
            thickness: 10,
            color: Colors.white,
            thicknessUnit: GaugeSizeUnit.logicalPixel,
          ),
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 30,
              color: Colors.blue[400]!,
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 30,
              endValue: 70,
              color: Colors.green[400]!,
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 70,
              endValue: 100,
              color: Colors.red[400]!,
              startWidth: 10,
              endWidth: 10,
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: voltage,
              enableAnimation: true,
              animationType: AnimationType.easeOutBack,
              needleStartWidth: 1,
              needleEndWidth: 5,
              needleLength: 0.7,
              knobStyle: const KnobStyle(
                knobRadius: 0.08,
                color: Color.fromARGB(255, 255, 255, 255),
                borderWidth: 0.05,
                borderColor: Colors.white,
              ),
              needleColor: const Color.fromARGB(255, 255, 255, 255),
              tailStyle: const TailStyle(
                color: Colors.grey,
                width: 5,
                length: 0.2,
              ),
            ),
            RangePointer(
              value: voltage,
              width: 0.1,
              sizeUnit: GaugeSizeUnit.factor,
              // ignore: deprecated_member_use
              color: _getvoltageColor(voltage).withOpacity(0.3),
              enableAnimation: true,
              animationDuration: 1000,
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              angle: 90,
              positionFactor: 0.35,
              widget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 30),
                  Text(
                    '${voltage.toStringAsFixed(1)}°C',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _getvoltageStatus(voltage),
                    style: TextStyle(
                      fontSize: 16,
                      color: _getvoltageColor(voltage),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getvoltageColor(double temp) {
    if (temp < 30) return Colors.blue[700]!;
    if (temp < 70) return Colors.green[700]!;
    return Colors.red[700]!;
  }

  String _getvoltageStatus(double temp) {
    if (temp < 30) return 'COLD';
    if (temp < 70) return 'NORMAL';
    return 'HOT!';
  }

  
  
}
