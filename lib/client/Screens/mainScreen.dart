import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackefx_ecosense/client/Screens/Home/homeScreen.dart';
import 'package:hackefx_ecosense/client/Screens/Search/personalDetails.dart';
import 'package:hackefx_ecosense/client/controllers/bottomNavigationController.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final BottomNavigationController controller = Get.put(BottomNavigationController());

  final List<Widget> pages = [
    Homescreen(),
    PersonalVehicleDetails(),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 28, 29, 33),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              // Navigate to the personal details page (index 1)
              controller.changePage(1);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF17CF96).withOpacity(0.2),
              ),
              child: const Icon(
                Icons.person,
                color: Color(0xFF17CF96),
                size: 24,
              ),
            ),
          ),
        ),
        title: Center(child: Text('EcoSense +',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),)),
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.logout),style: ButtonStyle(),)],
      ),
      body: Obx(()=>pages[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(()=>BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 28, 29, 33),
        onTap: controller.changePage,
        currentIndex: controller.selectedIndex.value,
        selectedItemColor: const Color(0xFF17CF96),
        unselectedItemColor: Colors.grey,

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person_4_outlined), label: 'Profile'),
        ],
      ),)
    );
  }
}
