import 'package:flutter/material.dart';
import 'package:freeman/controller/rudder_controller.dart';

class Rudder extends StatelessWidget {
  const Rudder({Key? key, this.offsetX}) : super(key: key);
  final double? offsetX;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: List.generate(
      rudder.length,
      (index) => Positioned(
          left: RudderController.rudderPositionLeft(index: index),
          bottom: rudder[index]["bottom-position"] -
              RudderController.moveRudderToBottom[index],
          height: 60,
          child: Transform.rotate(
            child: Image.asset("assets/images/rudder.png"),
            angle: -RudderController.angle,
          )),
    ) /* [
        Positioned(
            left: RudderController.rudderPositionLeft(index: 0),
            bottom: rudder[0]["bottom-position"],
            height: 60,
            child: Transform.rotate(
              child: Image.asset("assets/images/rudder1.png"),
              angle: -RudderController.angle,
            )),
      ],*/
        );
  }
}

const List rudder = [
  {"left-position": 5800.0, "bottom-position": 132.0, "rudder-move": 0.0},
  {"left-position": 6200.0, "bottom-position": 132.0, "rudder-move": 0.0},
  {"left-position": 6600.0, "bottom-position": 132.0, "rudder-move": 0.0},
  {"left-position": 7000.0, "bottom-position": 132.0, "rudder-move": 0.0},
];
