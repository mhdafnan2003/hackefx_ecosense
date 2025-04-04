import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackefx_ecosense/client/Screens/mainScreen.dart';
import 'package:hackefx_ecosense/client/controllers/noderedAPIService.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: MainPage(),
    initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => ArduinoController());
      }),);
  }
}