// controllers/page_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageControlController extends GetxController {
  final PageController pageController = PageController(initialPage: 0);
  final RxInt currentPage = 0.obs;

  void changePage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    currentPage.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}