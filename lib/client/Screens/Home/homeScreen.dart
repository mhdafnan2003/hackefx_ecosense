import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackefx_ecosense/client/Screens/Details/engineDetails.dart';
import 'package:hackefx_ecosense/client/controllers/noderedAPIService.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});
  final ArduinoController controller = Get.put(ArduinoController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 29, 33),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(10, 49, 255, 162),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 180,
                width: double.infinity,
              ),
              SizedBox(height: 10),
              Text(
                'Sample Text',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: chechcontainer(
                      size: size,
                      heading: 'Engine',
                      subheading: 'Check the details',
                      onpress:
                          () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (ctx) =>
                                      Enginedetails(title: 'Engine Details', subtitle: 'Sample Subtitle',),
                            ),
                          ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: chechcontainer(
                      size: size,
                      heading: 'Ecu',
                      subheading: 'Check the details',
                      onpress: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: chechcontainer(
                      size: size,
                      heading: 'Cumbustion',
                      subheading: 'Check the details',
                      onpress: () {},
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: chechcontainer(
                      size: size,
                      heading: 'Mobility Health',
                      subheading: 'Check the details',
                      onpress: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class chechcontainer extends StatelessWidget {
  const chechcontainer({
    super.key,
    required this.size,
    required this.heading,
    required this.subheading,
    required this.onpress,
  });

  final Size size;
  final String heading;
  final String subheading;
  final GestureTapCallback onpress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onpress,
      child: Container(
        height: 100,
        width: size.width / 2,
        decoration: BoxDecoration(
          color: const Color.fromARGB(10, 49, 255, 162),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                heading,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Text(
                subheading,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w200,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// 