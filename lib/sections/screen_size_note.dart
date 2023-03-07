import 'package:flutter/material.dart';

class ScreenSizeNote extends StatelessWidget {
  const ScreenSizeNote({Key? key, this.width, this.height}) : super(key: key);
  final double? width, height;
  @override
  Widget build(BuildContext context) {
    return height! > 360 || width! > 720
        ? Container(
            alignment: Alignment.center,
            color: const Color(0xFFebbd34),
            child: const Text(
              "The screen size is not appropriate. \n 360 x 720 or 360 x 710 is required sizes for now. \n The Design will be responsive in next time. \n The project is under construction. \n Thanks",
              textAlign: TextAlign.center,
              style: TextStyle(height: 1.3, fontWeight: FontWeight.bold),
            ))
        : const SizedBox();
  }
}
