import 'package:flutter/material.dart';

class Character extends StatelessWidget {
  const Character({Key? key, this.controll}) : super(key: key);
  final dynamic controll;
  @override
  Widget build(BuildContext context) {
    // controll.updateFunctions();
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(children: [
        Positioned(
            //  left: 0,
            child: Image.asset("assets/images/character/stop.png",
                width: controll.stopAnimeState)),
        Positioned(
            //left: 200,
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
    );
  }
}
