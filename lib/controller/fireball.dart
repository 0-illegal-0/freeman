import 'dart:math';

import 'package:freeman/controller/character_controller.dart';
import 'package:freeman/controller/move.dart';
import 'package:get/get.dart';

class FireBallController extends GetxController {
  static int moveDown = 0;
  static int fireBallRondomValues = 0;
  static int fireBallCount = 8;
  static List<double> fireBallLeftPosition = [];
  static List<double> fireBallBotoomPosition = [];
  static const double fireBallHeight = 41;
  static const double fireBallwidth = 30;
  getRondomFireBallValues() {
    fireBallLeftPosition.add(Random().nextInt(700) + 2500.0);
    fireBallBotoomPosition.add(Random().nextInt(220) + 140.0);
    fireBallRondomValues++;
    if (fireBallRondomValues < fireBallCount) {
      getRondomFireBallValues();
    }
  }

  bool executeAnimateLossPosition = false;
  whenFireBallTouchAvatar({int? fireBallIndex}) {
    if (fireBallBotoomPosition[fireBallIndex!] <
            Move.freemanPositionY + CharacterController.characterMainHeight &&
        fireBallBotoomPosition[fireBallIndex] + fireBallHeight >
            Move.freemanPositionY &&
        fireBallLeftPosition[fireBallIndex] - Move.offsetX <
            Move.freemanPositionX + CharacterController.characterMainWidth &&
        fireBallLeftPosition[fireBallIndex] - Move.offsetX + fireBallwidth >
            Move.freemanPositionX) {
      Move.rankStateTitle = "Game Over";
      Move.fail = true;
      Move.result = 500;
      if (executeAnimateLossPosition == false) {
        executeAnimateLossPosition = true;
        animateLossPosition();
      }
    }
  }

  dynamic cont = Move(width: 720);
  animateLossPosition() async {
    print("+++++");
    await Future.delayed(const Duration(milliseconds: 5), () {
      Move.leftLossPosition = Move.leftLossPosition! + 5;
    });
    if (Move.leftLossPosition! < cont.width! * 0.67) {
      print("....${Move.leftLossPosition}");

      animateLossPosition();
    }
    update();
  }

  fireBallAnimation() async {
    getRondomFireBallValues();
    await Future.delayed(const Duration(milliseconds: 20), () {
      for (var i = 0; i < fireBallCount; i++) {
        whenFireBallTouchAvatar(fireBallIndex: i);
        fireBallBotoomPosition[i] = fireBallBotoomPosition[i] - 2;
        if (fireBallBotoomPosition[i] < 30) {
          fireBallBotoomPosition[i] = 370;
          fireBallLeftPosition[i] = Random().nextInt(700) + 2500.0;
        }
      }
    });
    fireBallAnimation();
    update();
  }

  @override
  void onInit() {
    fireBallAnimation();
    // TODO: implement onInit
    super.onInit();
  }
}
