import 'package:flutter/material.dart';

class Character extends StatelessWidget {
  const Character({Key? key, this.controll, this.rotateY}) : super(key: key);
  final dynamic controll;
  final double? rotateY;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Transform(
        origin: const Offset(40, 40),
        transform: Matrix4.rotationX(0)..rotateY(rotateY!),
        child: Stack(children: [
          Positioned(
              child: Image.asset("assets/images/character/stop.png",
                  width: controll.stopAnimeState)),
          Positioned(
              child: Image.asset("assets/images/character/run-1.png"),
              width: controll.characterWidth[0]),
          Positioned(
              child: Image.asset("assets/images/character/run-2.png"),
              width: controll.characterWidth[1]),
          Positioned(
              child: Image.asset("assets/images/character/run-3.png"),
              width: controll.characterWidth[2]),
          Positioned(
              child: Image.asset("assets/images/character/jump-1.png"),
              width: controll.jumpeAnimeState),
        ]),
      ),
    );
  }
}
