import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackefx_ecosense/client/Screens/Details/detailsScreen.dart';
import 'package:hackefx_ecosense/client/Screens/Home/homeScreen.dart';
import 'package:hackefx_ecosense/client/Screens/Search/searchScreen.dart';
import 'package:hackefx_ecosense/client/controllers/bottomNavigationController.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final BottomNavigationController controller = Get.put(BottomNavigationController());

  final List<Widget> pages = [
    Homescreen(),
    Searchscreen(),
    Detailsscreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Obx(()=>pages[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(()=>BottomNavigationBar(
        onTap: controller.changePage,
        currentIndex: controller.selectedIndex.value,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Details'),
        ],
      ),)
    );
  }
}
