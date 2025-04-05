import 'package:flutter/material.dart';

class GaugeSmallContainer extends StatelessWidget {
  const GaugeSmallContainer({
    super.key,
    required this.size,
    required this.title,
    required this.onpress,
  });

  final Size size;
  final String title;
  final GestureTapCallback onpress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      hoverColor: const Color.fromARGB(66, 23, 207, 149),
      splashColor: const Color(0xFF17CF96),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 90,
        width: size.width * .35,
        decoration: BoxDecoration(
          color: const Color.fromARGB(10, 49, 255, 162),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}