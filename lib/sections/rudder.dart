import 'package:flutter/material.dart';
import 'package:freeman/controller/rudder_controller.dart';

class Rudder extends StatelessWidget {
  const Rudder({Key? key, this.offsetX}) : super(key: key);
  final double? offsetX;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: RudderController.rudderPositionLeft,
        bottom: rudder[0]["bottom-position"],
        height: 60,
        child: Transform.rotate(
          child: Image.asset("assets/images/rudder1.png"),
          angle: -RudderController.angle,
        ));
  }
}

const List rudder = [
  {"width": 250.0, "left-position": 5650.0, "bottom-position": 132.0},
];
