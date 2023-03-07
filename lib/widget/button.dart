import 'package:flutter/material.dart';
import 'package:freeman/controller/air_land_controller.dart';
import 'package:freeman/controller/move.dart';

class MoveButtons extends StatelessWidget {
  const MoveButtons({
    Key? key,
    required this.moveController,
    this.airLandController,
  }) : super(key: key);

  final Move moveController;
  final AirLandController? airLandController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 50,
        bottom: 20,
        child: Row(children: [
          GestureDetector(
              onPanStart: (details) {
                Move.back = true;
                moveController.toBack();
              },
              onPanEnd: (details) {
                Move.back = false;
              },
              child: Container(
                  padding: const EdgeInsets.all(17.5),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(172, 164, 177, 0.4)),
                  child:
                      Image.asset("assets/images/left-button.png", width: 35))),
          const SizedBox(width: 40),
          GestureDetector(
              onPanStart: (details) {
                Move.forwod = true;
                moveController.toForward();
              },
              onPanEnd: (details) {
                Move.forwod = false;
              },
              child: Container(
                  padding: const EdgeInsets.all(17.5),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(172, 164, 177, 0.4)),
                  child: Image.asset("assets/images/right-button.png",
                      width: 35))),
        ]));
  }
}
