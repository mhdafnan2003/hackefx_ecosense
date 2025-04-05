import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackefx_ecosense/client/Screens/Details/widgets/custom_guage.dart';
import 'package:hackefx_ecosense/client/Screens/Details/widgets/gaugeSmallContainer.dart';
import 'package:hackefx_ecosense/client/controllers/gaugeController.dart';
import 'package:hackefx_ecosense/client/controllers/noderedAPIService.dart';

class Comoustiondetails extends StatelessWidget {
  Comoustiondetails({super.key, required this.title, required this.subtitle});
  final ArduinoController controller = Get.put(ArduinoController());
  final PageControlController pageCtrl = Get.put(PageControlController());
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 29, 33),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 28, 29, 33),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.filter_list))],
      ),
      body: Obx(() {
        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text("Error: ${controller.errorMessage.value}"));
        }

        // Safely parse all sensor values
        final sensorData = controller.sensorData['data'] ?? {};

        // final tempValue =
        //     double.tryParse(sensorData['Temperature']?.toString() ?? '0') ?? 0;
        // final humidityValue =
        //     double.tryParse(sensorData['Humidity']?.toString() ?? '0') ?? 0;
         final smokeValue =
             double.tryParse(sensorData['SmokeValue']?.toString() ?? '0') ?? 0;
        // final oilLevel =
        //     double.tryParse(sensorData['OilLevel']?.toString() ?? '0') ?? 0;
        // final vibrationValue =
        //     double.tryParse(
        //       sensorData['VibrationValue']?.toString() ?? '0',
        //     ) ??
        //     0;

        // For debugging - print all values
        // debugPrint('''
        //   Temperature: $tempValue°C
        //   Humidity: $humidityValue%
        //   Smoke: $smokeValue ppm
        //   Oil Level: $oilLevel units
        //   Vibration: $vibrationValue units
        // ''');

      

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   title,
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.w600,
              //     color: Colors.white,
              //   ),
              // ),
              // Text(
              //   subtitle,
              //   style: TextStyle(
              //     fontSize: 14,
              //     fontWeight: FontWeight.w300,
              //     color: Colors.white,
              //   ),
              // ),
              SizedBox(height: 20),
              SizedBox(
                height: 250,
                child: PageView(
                  controller: pageCtrl.pageController,
                  onPageChanged: (index) => pageCtrl.currentPage.value = index,
                  children: [
                    Custom__smoke_gauge(Value: smokeValue),
                    
                   
                  ],
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GaugeSmallContainer(
                      size: size,
                      title: 'Gas',
                      onpress: () {
                        pageCtrl.changePage(0);
                      },
                    ),
                    
                    
                  ],
                ),
              ),
            ],

            // TemperatureGauge(temperature: tempValue),
            // const SizedBox(height: 20),
            // // Display other sensor values
            // _buildSensorCard('Humidity', '$humidityValue%'),
            // _buildSensorCard('Smoke Level', '$smokeValue ppm'),
            // TemperatureGauge(temperature: smokeValue),
            // _buildSensorCard('Oil Level', '$oilLevel units'),
            // _buildSensorCard('Vibration', '$vibrationValue units'),
          ),
        );
      }),
    );
  }
}




