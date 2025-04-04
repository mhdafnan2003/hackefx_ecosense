import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackefx_ecosense/client/controllers/noderedAPIService.dart';

class Circularprogress extends StatelessWidget {
  const Circularprogress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

class ErrorCircular extends StatelessWidget {
   ErrorCircular({super.key});
  final ArduinoController controller = Get.put(ArduinoController());


  @override
  Widget build(BuildContext context) {
    return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(
                  'Error: ${controller.errorMessage.value}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
  }
}