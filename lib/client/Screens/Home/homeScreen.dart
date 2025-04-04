import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackefx_ecosense/client/Screens/Home/widgets/radialGauge.dart';
import 'package:hackefx_ecosense/client/controllers/noderedAPIService.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});
  final ArduinoController controller = Get.put(ArduinoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(() {
          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text("Error: ${controller.errorMessage.value}"));
          }
        
          // Safely parse all sensor values
          final sensorData = controller.sensorData['data'] ?? {};
          
          final tempValue = double.tryParse(sensorData['Temperature']?.toString() ?? '0') ?? 0;
          final humidityValue = double.tryParse(sensorData['Humidity']?.toString() ?? '0') ?? 0;
          final smokeValue = double.tryParse(sensorData['SmokeValue']?.toString() ?? '0') ?? 0;
          final oilLevel = double.tryParse(sensorData['OilLevel']?.toString() ?? '0') ?? 0;
          final vibrationValue = double.tryParse(sensorData['VibrationValue']?.toString() ?? '0') ?? 0;
        
          // For debugging - print all values
          // debugPrint('''
          //   Temperature: $tempValue°C
          //   Humidity: $humidityValue%
          //   Smoke: $smokeValue ppm
          //   Oil Level: $oilLevel units
          //   Vibration: $vibrationValue units
          // ''');
        
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(child: TemperatureGauge(temperature: tempValue)),
                      Expanded(child: TemperatureGauge(temperature: tempValue)),
                    ],
                  )
                  // TemperatureGauge(temperature: tempValue),
                  // const SizedBox(height: 20),
                  // // Display other sensor values
                  // _buildSensorCard('Humidity', '$humidityValue%'),
                  // _buildSensorCard('Smoke Level', '$smokeValue ppm'),
                  // TemperatureGauge(temperature: smokeValue),
                  // _buildSensorCard('Oil Level', '$oilLevel units'),
                  // _buildSensorCard('Vibration', '$vibrationValue units'),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSensorCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 18)),
            Text(value, 
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}