import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freeman/controller/fireball.dart';
import 'package:freeman/controller/move.dart';

class FireBall extends StatelessWidget {
  const FireBall(
      {Key? key,
      this.moveDown,
      this.fireBallCount,
      this.fireBallLeftPosition,
      this.fireBallBotoomPosition})
      : super(key: key);
  final int? moveDown, fireBallCount;
  final List<double>? fireBallLeftPosition, fireBallBotoomPosition;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: List.generate(
            FireBallController.fireBallCount,
            (index) => Positioned(
                left: fireBallLeftPosition![index] - Move.offsetX,
                bottom: fireBallBotoomPosition![index],
                child: Image.asset("assets/images/fire-icon/fireball.png",
                    width: 30))));
  }
}
