import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackefx_ecosense/client/Screens/Details/comoustionDetails.dart';
import 'package:hackefx_ecosense/client/Screens/Details/ecuDetails.dart';
import 'package:hackefx_ecosense/client/Screens/Details/engineDetails.dart';
import 'package:hackefx_ecosense/client/Screens/Details/mobilityDetails.dart';
import 'package:hackefx_ecosense/client/Screens/Home/productive.dart';
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
  height: 180,
  width: double.infinity,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFF17CF96).withOpacity(0.6),
        const Color(0xFF1C1D21).withOpacity(0.8),
      ],
    ),
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Stack(
      children: [
        Image.asset(
          'assets/images/car_image.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            print("Error loading asset image: $error");
            return Container(
              color: const Color(0xFF17CF96).withOpacity(0.3),
              child: const Center(
                child: Icon(
                  Icons.directions_car,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                const Color(0xFF1C1D21).withOpacity(0.7),
              ],
            ),
          ),
        ),
        const Positioned(
          bottom: 16,
          left: 16,
          child: Text(
            'KL 07 X 069',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: Text(
            'Eco ID : KL24RF99 ',
            style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  ),
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

                      onpress:
                          () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (ctx) => Enginedetails(
                                    title: 'Engine Details',
                                    subtitle: 'Sample Subtitle',
                                  ),
                            ),
                          ),
                      icon: Icons.minor_crash_sharp,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: chechcontainer(
                      size: size,
                      heading: 'ECU',

                      onpress: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (ctx) => Ecudetails()
                            ),
                          ),
                      icon: Icons.developer_board_rounded,
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
                      heading: 'Combustion',

                      onpress:
                          () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (ctx) => Comoustiondetails(
                                    title: 'Combustion Details',
                                    subtitle: 'Sample Subtitle',
                                  ),
                            ),
                          ),
                      icon: Icons.thermostat,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: chechcontainer(
                      size: size,
                      heading: 'Mobility Health',

                      onpress:
                          () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (ctx) => Mobilitydetails(
                                    title: 'Mobility Details',
                                    subtitle: 'Sample Subtitle',
                                  ),
                            ),
                          ),
                      icon: Icons.local_hospital_outlined,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (ctx) => Productive()
                            ),
                          ),
                hoverColor: const Color.fromARGB(66, 23, 207, 149),
                splashColor: const Color(0xFF17CF96),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(10, 49, 255, 162),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 75,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bar_chart_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(width: 35),
                        Text(
                          'Predictive Analysis',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward,
                          size: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
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

    required this.onpress,
    required this.icon,
  });

  final Size size;
  final String heading;

  final GestureTapCallback onpress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onpress,
      hoverColor: const Color.fromARGB(66, 23, 207, 149),
      splashColor: const Color(0xFF17CF96),
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
              Icon(icon, color: Colors.white),
              Text(
                heading,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
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