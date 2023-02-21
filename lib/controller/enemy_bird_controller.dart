import 'dart:math';

import 'package:freeman/controller/move.dart';
import 'package:freeman/sections/enemy_bird.dart';
import 'package:get/get.dart';

class EnemyBirdContoller extends GetxController {
  List<double> wingState = [0, 0, 0, 0];
  int index = 0;
  double angle = 0.0;
  static double birdWidth = 80;
  bool wingAnimationSwitch = true;

  int wingAnimationDuration =
      1500; //Note : - I do this so that the resources of the device are not consumed unnecessarily
  wingAnimation() async {
    if (Move.offsetX > 5000 && Move.offsetX < 7000) {
      wingAnimationDuration = 20;
    } else {
      wingAnimationDuration = 1500;
    }
    await Future.delayed(Duration(milliseconds: wingAnimationDuration), () {
      if (angle < 3.2 && wingAnimationSwitch == true) {
        angle = angle + 0.2;
      } else {
        wingAnimationSwitch = false;
        angle = angle - 0.2;
        if (angle < 0) {
          wingAnimationSwitch = true;
        }
      }
    });

    wingAnimation();
    update();
  }

  List<Map> bombTopValues = [];

  createBombValues() {
    for (var i = 0; i < enemyBirds.length; i++) {
      bombTopValues.add({
        "position-bottom": 0.0,
        "duration": Random().nextInt(20) + 10,
        "position-left": 0.0
      });
    }
  }

  double moveBirdUnit = 0.0;

  moveBirdAnimation(index) async {
    if (Move.offsetX > 5000) {
      moveBirdUnit = 2;
    }
    await Future.delayed(
        Duration(milliseconds: bombTopValues[index]['duration']), () {
      bombTopValues[index]['position-left'] =
          bombTopValues[index]['position-left'] + moveBirdUnit;
    });
    if (bombTopValues[index]['position-left'] < 4000) {
      moveBirdAnimation(index);
    } else {
      birdWidth = 0;
    }
    update();
  }

  static double get avatarPositionY {
    return Move.freemanPositionY - Move.offsetY;
  }

  double enemyBirdFinalLeftPosition(index) {
    return enemyBirds[index!]['left-position'] -
        bombTopValues[index]['position-left'] +
        35 -
        Move.offsetX;
  }

  double enemyBirdFinalBottomPosition(index) {
    return enemyBirds[index!]['bottom-position'] -
        bombTopValues[index]['position-bottom'];
  }

  int birdAnimationDuration = 1500;

  birdAttack(index) async {
    if (Move.offsetX > 5000 && Move.offsetX < 7000) {
      birdAnimationDuration = 10;
    } else {
      birdAnimationDuration = 1500;
    }
    await Future.delayed(Duration(milliseconds: birdAnimationDuration), () {
      bombTopValues[index]['position-bottom'] =
          bombTopValues[index]['position-bottom'] + 2;
    });
    if (enemyBirds[index!]['bottom-position'] -
            bombTopValues[index]['position-bottom'] >
        -10) {
      birdAttack(index);
    } else {
      bombTopValues[index]['position-bottom'] = 0.0;
      birdAttack(index);
    }
    if (enemyBirdFinalBottomPosition(index) < avatarPositionY + 25 &&
            enemyBirdFinalBottomPosition(index) > avatarPositionY &&
            enemyBirdFinalLeftPosition(index) + 10 > Move.freemanPositionX &&
            enemyBirdFinalLeftPosition(index) + 10 <
                Move.freemanPositionX + 25 ||
        enemyBirdFinalBottomPosition(index) < avatarPositionY + 25 &&
            enemyBirdFinalBottomPosition(index) > avatarPositionY &&
            enemyBirdFinalLeftPosition(index) > Move.freemanPositionX &&
            enemyBirdFinalLeftPosition(index) < Move.freemanPositionX + 25) {
      print("You are killed $index");
    }
    update();
  }

  executeCollectionFunctions() {
    birdAttack(0);
    moveBirdAnimation(0);
    birdAttack(1);
    moveBirdAnimation(1);
    birdAttack(2);
    moveBirdAnimation(2);
    birdAttack(3);
    moveBirdAnimation(3);
    birdAttack(4);
    moveBirdAnimation(4);
  }

  @override
  void onInit() {
    createBombValues();
    wingAnimation();
    executeCollectionFunctions();
    super.onInit();
  }
}
