import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freeman/controller/air_land_controller.dart';
import 'package:freeman/controller/character_controller.dart';
import 'package:freeman/controller/enemy_bird_controller.dart';
import 'package:freeman/functions/function.dart';
import 'package:freeman/main.dart';
import 'package:freeman/sections/air_and.dart';
import 'package:freeman/sections/hole.dart';
import 'package:get/get.dart';

class Move extends GetxController {
  Move();
  double offsetMove = 0;
  static double surfaceMarginLeft = 0;
  static bool forwod = false;
  static bool back = false;
  static List<double> stagesWidth = [9940];
  static double offsetX = 0, offsetY = 0;

  toForward() async {
    await Future.delayed(const Duration(seconds: 0), () async {
      forwardHorizontalLandeMove();
      currentAvatarState();
      avatarForwardWithLand();
      if (forwod == true && fail == false) {
        await forward();
      } else {
        await failAnimate();
      }
    });
    if (forwod == true) {
      await toForward();
    }
    print("This is OffsetX" "${Move.offsetX}");
  }

  toBack() async {
    await Future.delayed(const Duration(seconds: 0), () async {
      backHorizontalLandeMove();
      currentAvatarState();
      avatarBackWithLand();
      if (back == true && fail == false) {
        await goBack();
      } else {
        await failAnimate();
      }
    });
    if (back == true) {
      toBack();
    }
  }

  static double freemanPositionY = 135;
  static double freemanPositionX = 133;

  //int indexHoleList = 0;
  GetCurrentIndex getCurrentIndexInstance = GetCurrentIndex();
  double get finalposition {
    return holePosition[getCurrentIndexInstance.elementIndex]['margin-left']! -
        offsetX;
  }

  bool avatarWithBarrierState = false;
  bool foreOne = true;
  int barierindex = 0;

  forward() async {
    getCurrentIndexInstance.getCurrentElementIndex(
        element: holePosition,
        elementLeftPosition: finalposition,
        elementWidth: holePosition[getCurrentIndexInstance.elementIndex]
            ['width']);
    checkFailState();
    await Future.delayed(const Duration(milliseconds: 1), () async {
      offsetX++;
    });
    update();
  }

  goBack() async {
    getCurrentIndexInstance.getCurrentElementIndex(
        element: holePosition,
        elementLeftPosition: finalposition,
        elementWidth: holePosition[getCurrentIndexInstance.elementIndex]
            ['width']);
    checkFailState();
    await Future.delayed(const Duration(milliseconds: 1), () async {
      offsetX--;
    });
    update();
  }

  avatarMainBottomMargin() async {
    if (freemanPositionY > 135 && avatarWithBarrierState == true) {
      await Future.delayed(const Duration(milliseconds: 3), () {
        freemanPositionY = freemanPositionY - 1;
      });
      avatarMainBottomMargin();
    } else {
      avatarWithBarrierState = false;
    }
  }

  bool fail = false;
  failAnimate() async {
    await Future.delayed(const Duration(milliseconds: 3), () {
      if (fail == true) {
        freemanPositionY = freemanPositionY - 2;
      }
    });
    if (freemanPositionY > -25 && fail == true) {
      failAnimate();
    }
    update();
  }

  bool jump = true;
  bool jumpComplete = false;
  static bool jumpState = true;

  jumpAnime() async {
    jumpState = false;
    await Future.delayed(const Duration(milliseconds: 1), () {
      if (jump == true && freemanPositionY++ - offsetY < 290) {
        freemanPositionY++;
      } else {
        jump = false;
        {
          if (freemanPositionY > AirLandController.mainSiteAvatare) {
            freemanPositionY--;
          } else {
            jump = true;
            jumpComplete = true;
          }
        }
      }
      update();
    });
    if (jumpComplete == false) {
      jumpAnime();
    } else {
      jumpState = true;
      jumpComplete = false;
      checkFailState();
      failAnimate();
    }
  }

  checkFailState() {
    if (landState == false) {
      if (fail == false) {
        if (finalposition < freemanPositionX &&
            finalposition >
                freemanPositionX -
                    holePosition[getCurrentIndexInstance.elementIndex]['width']!
                        .toInt() +
                    CharacterController.characterMainWidth &&
            freemanPositionY == 135) {
          fail = true;
        }
      }
    } else {
      if (fail == false) {
        if (freemanPositionX > finalposition &&
                avatarMoveState != true &&
                freemanPositionY == 135 &&
                currentLandPosition >
                    freemanPositionX + CharacterController.characterMainWidth &&
                finalposition >
                    freemanPositionX -
                        holePosition[getCurrentIndexInstance.elementIndex]
                                ['width']!
                            .toInt() +
                        CharacterController.characterMainWidth ||
            freemanPositionY == 139 &&
                avatarMoveState == true &&
                currentLandPosition >
                    freemanPositionX + CharacterController.characterMainWidth ||
            freemanPositionX > currentLandPosition + 150 &&
                freemanPositionX + CharacterController.characterMainWidth <
                    finalposition +
                        holePosition[getCurrentIndexInstance.elementIndex]
                                ['width']!
                            .toInt() &&
                freemanPositionY == 135) {
          fail = true;
        }
      }
    }
  }

//----------------------------- Coin ---------------------------

  int get number0 {
    return Random().nextInt(5) + 10;
  }

  int coinCurrentIndex = 0;
  double get currentCointPositionX {
    return coins[coinCurrentIndex]['left-position'] - Move.offsetX;
  }

  int get currentCointCount {
    return coins[coinCurrentIndex]['count'];
  }

  double get fullCollectionWidth {
    return currentCointCount * 35;
  }

  double get minIndexPosition {
    if (coinCurrentIndex < 1) {
      return 0.0;
    } else {
      return coins[coinCurrentIndex - 1]["max-index-position"];
    }
  }

  getCurrentIndex() {
    if (Move.offsetX > coins[coinCurrentIndex]["max-index-position"] &&
        coinCurrentIndex < coins.length - 1) {
      coinCurrentIndex++;
    }
    if (Move.offsetX < minIndexPosition) {
      coinCurrentIndex--;
    }
  }

  int duration = 1000;
  coinListener() async {
    getCurrentIndex();
    await Future.delayed(Duration(milliseconds: duration), () {
      if (currentCointPositionX < 710 && currentCointPositionX > -100) {
        duration = 30;
      } else {
        duration = 1000;
      }
    });
    if (currentCointPositionX < 710 && currentCointPositionX > -100) {
      coinEffect();
    } else {
      coinListener();
    }
  }

  int get collectionIndexCount {
    if (coinCurrentIndex < 1) {
      return 0;
    } else {
      return coins[coinCurrentIndex - 1]['count'];
    }
  }

  coinEffect() async {
    double coinwidth = 0;
    await Future.delayed(const Duration(milliseconds: 10), () {
      for (var i = 0; i < currentCointCount; i++) {
        if (Move.freemanPositionX <
                coins[coinCurrentIndex]['left-position'] -
                    Move.offsetX +
                    35 +
                    coinwidth &&
            Move.freemanPositionX + CharacterController.characterMainWidth >
                coins[coinCurrentIndex]['left-position'] +
                    coinwidth -
                    Move.offsetX &&
            freemanPositionY > 205 &&
            freemanPositionY < 265) {
          coinsColor[i + collectionIndexCount] = const Color(0xFFcacccb);
        }
        coinwidth = coinwidth + 35;
      }
    });
    if (currentCointPositionX < 225 && currentCointPositionX > -100) {
      coinEffect();
    } else {
      coinListener();
    }
  }

  static List<Color> coinsColor = [
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.green
  ];

// ---------------------- Move Land ----------------------

  int checkLandDuration = 1000, currentLandIndex = 0;
  bool landState = false;

  updateFreemanPosition() async {
    if (freemanPositionX > 100) {
      await Future.delayed(const Duration(milliseconds: 10), () {
        freemanPositionX = freemanPositionX - 2;
        if (freemanPositionX < 100) {
          freemanPositionX = 100;
        }
      });
      updateFreemanPosition();
    }
    update();
  }

  forwardHorizontalLandeMove() {
    if (moveLands[currentLandIndex]['effective-range']! - Move.offsetX <
        Move.freemanPositionX) {
      landState = true;
    }
  }

  backHorizontalLandeMove() {
    if (moveLands[currentLandIndex]['effective-range']! - Move.offsetX >
        Move.freemanPositionX) {
      landState = false;
    }
  }

  static double horizontalLand = 0.0;
  bool landRightMove = false;
  bool landLeftMove = true;
  String avatarState = "toRight";

  currentAvatarState() {
    if (Move.freemanPositionX + CharacterController.characterMainWidth >
        holePosition[2]['margin-left']!.toInt() + 550 - Move.offsetX) {
      avatarState = "toLeft";
    } else {
      avatarState = "toRight";
    }
  }

  int landNoveLoopDuration = 2000;
  bool updateFreemanPositionForOnce = true;
  landNoveEffect() async {
    if (Move.offsetX > 500 && Move.offsetX < 5800) {
      landNoveLoopDuration = 10;
    } else {
      landNoveLoopDuration = 2000;
    }
    await Future.delayed(Duration(milliseconds: landNoveLoopDuration), () {
      if (landRightMove == false) {
        landToRight();
        avatarWithLand();
      } else {
        avatarWithLand();
        landToleft();
      }
    });
    if (offsetX > 1700) {
      if (updateFreemanPositionForOnce == true) {
        updateFreemanPositionForOnce = false;
        updateFreemanPosition();
      }
    }
    landNoveEffect();
    update();
  }

  bool testPlus = true;
  double testDouble = 2;
  avatarWithLand() {
    if (avatarMoveState == false &&
        Move.freemanPositionY == 135 &&
        Move.freemanPositionX + CharacterController.characterMainWidth >
            currentLandPosition &&
        Move.freemanPositionX < currentLandPosition + 150 &&
        Move.freemanPositionX > finalposition &&
        Move.freemanPositionX <
            finalposition +
                holePosition[getCurrentIndexInstance.elementIndex]['width']!
                    .toInt()) {
      if (landRightMove == false) {
        avatarMoveState = true;
        Move.freemanPositionX = Move.freemanPositionX + testDouble;
      } else if (landRightMove != false) {
        Move.freemanPositionX = Move.freemanPositionX - testDouble;
        avatarMoveState = true;
      }
    } else if (Move.freemanPositionY == 135 &&
        currentLandPosition <
            Move.freemanPositionX + CharacterController.characterMainWidth &&
        currentLandPosition + 150 > Move.freemanPositionX &&
        avatarState == "toRight") {
      if (landRightMove == false) {
        avatarMoveState = true;
        Move.freemanPositionX = Move.freemanPositionX + testDouble;
      } else if (landRightMove != false &&
          avatarMoveState == true &&
          horizontalLand < 394.0) {
        Move.freemanPositionX = Move.freemanPositionX - testDouble;
      }
    } else if (avatarMoveState == false &&
        currentLandPosition + 150 > Move.freemanPositionX &&
        Move.freemanPositionY == 135 &&
        Move.freemanPositionX <
            finalposition +
                holePosition[getCurrentIndexInstance.elementIndex]['width']!
                    .toInt() &&
        Move.freemanPositionX + CharacterController.characterMainWidth >
            finalposition +
                holePosition[getCurrentIndexInstance.elementIndex]['width']!
                    .toInt()) {
      if (landRightMove == false && avatarMoveState == true) {
        Move.freemanPositionX = Move.freemanPositionX + testDouble;
      } else if (landRightMove != false) {
        Move.freemanPositionX = Move.freemanPositionX - testDouble;
        avatarMoveState = true;
      }
    } else if (avatarMoveState == true && Move.freemanPositionY == 135) {
      if (landRightMove == false && avatarMoveState == true) {
        Move.freemanPositionX = Move.freemanPositionX + testDouble;
      } else if (landRightMove != false && horizontalLand < 394.0) {
        Move.freemanPositionX = Move.freemanPositionX - testDouble;
        avatarMoveState = true;
      }
    } else {
      avatarMoveState = false;
    }
  }

  landToRight() {
    horizontalLand = horizontalLand + 2;
    if (horizontalLand == 394) {
      landRightMove = true;
    }
  }

  landToleft() {
    horizontalLand = horizontalLand - 2;
    if (horizontalLand == 0) {
      landRightMove = false;
    }
  }

  static double get currentLandPosition {
    return moveLands[0]['margin-left']! - Move.offsetX + horizontalLand;
  }

  avatarForwardWithLand() {
    //  finalposition = holePosition[indexHoleList]['margin-left']! - offsetX;
    if (Move.freemanPositionX >
        finalposition +
            holePosition[getCurrentIndexInstance.elementIndex]['width']!
                .toInt()) {
      avatarMoveState = false;
    }
    if (landState == true) {
      if (Move.freemanPositionY == 135 &&
          currentLandPosition <
              Move.freemanPositionX + CharacterController.characterMainWidth &&
          currentLandPosition + 150 >
              Move.freemanPositionX + CharacterController.characterMainWidth) {
        Move.freemanPositionX = Move.freemanPositionX + 1;
        avatarMoveState = true;
      } else {
        avatarMoveState = false;
      }
      avatarMoveToRight();
    }
  }

  double avatarMoveBack = 0;

  avatarBackWithLand() {
    if (Move.freemanPositionX + CharacterController.characterMainWidth <
        finalposition) {
      avatarMoveState = false;
    }
    if (landState == true && avatarMoveState == true) {
      if (Move.freemanPositionY == 135 &&
          currentLandPosition + 150 >
              Move.freemanPositionX + CharacterController.characterMainWidth &&
          currentLandPosition >
              Move.freemanPositionX + CharacterController.characterMainWidth) {
        Move.freemanPositionX = Move.freemanPositionX - 1;
        avatarMoveState = true;
      } else {
        avatarMoveState = false;
      }
      avatarMoveToleft();
    }
  }

  double avatarMove = 0;
  bool avatarMoveState = false;
  avatarMoveToRight() {
    if (avatarMoveState == true) {
      avatarMove++;
    }
  }

  avatarMoveToleft() {
    if (avatarMoveState == true) {
      avatarMove--;
    }
  }

  @override
  void onInit() async {
    coinListener();
    landNoveEffect();
    super.onInit();
  }

  static void moveBirdAnimation(int i) {}
}

const List coins = [
  {
    "count": 3,
    "left-position": 800.0,
    "bottom-position": 230.0,
    "max-position": 735.0,
    "min-position": 675.0,
    "max-index-position": 825.0
  },
  {
    "count": 4,
    "left-position": 1500.0,
    "bottom-position": 230.0,
    "max-position": 1435.0,
    "min-position": 1375.0,
    "max-index-position": 1520.0
  }
];

const List<Map<String, double>> moveLands = [
  {'margin-left': 1204, 'effective-range': 1040},
];

const List<Map<String, double>> barriers = [
  {'margin-left': 2050, 'height': 100, 'margin-bottom': 135, 'width': 200},
  {'margin-left': 2450, 'height': 100, 'margin-bottom': 135, 'width': 200},
  {'margin-left': 2900, 'height': 100, 'margin-bottom': 135, 'width': 200}
];







/* barier functions

  forward() async {
    finalposition = holePosition[indexHoleList]['margin-left']! - offsetX;

    if (finalposition < holePosition[indexHoleList]['minimum-margin']! &&
        indexHoleList < holePosition.length - 1) {
      indexHoleList++;
    }
    checkFailState();
    getCurrentBarriersIndex();
    await Future.delayed(const Duration(milliseconds: 1), () async {
      if (barriers[0]['margin-left']! - offsetX <= freemanPositionX + 25 &&
          barriers[0]['margin-left']! - offsetX + 200 > freemanPositionX) {
        if (freemanPositionY >= 235) {
          offsetX++;
          avatarWithBarrierState = true;
          foreOne = true;
        }
      } else {
        if (foreOne == true) {
          await avatarMainBottomMargin();
          foreOne = false;
        }
        offsetX++;
      }
    });
    update();
  }

  ------------------------------------------

    goBack() async {
    if (indexHoleList > 0 &&
        indexHoleList < holePosition.length &&
        holePosition[holePosition.length - 1]['margin-left']! - offsetX >
            freemanPositionX) {
      trick = 1;
      lastStageHole = false;
    } else {
      lastStageHole = true;
      trick = 0;
    }

    finalposition =
        holePosition[indexHoleList - trick]['margin-left']! - offsetX;
    checkFailState();

    if (finalposition >= freemanPositionX &&
        indexHoleList > 0 &&
        lastStageHole != true) {
      indexHoleList--;
    }
    getCurrentBarriersIndex();
    await Future.delayed(const Duration(milliseconds: 1), () async {
      if (barriers[0]['margin-left']! - offsetX < freemanPositionX + 25 &&
          barriers[0]['margin-left']! - offsetX + 200 >= freemanPositionX) {
        if (freemanPositionY >= 235) {
          offsetX--;
          avatarWithBarrierState = true;
          foreOne = true;
        }
      } else {
        if (foreOne == true) {
          await avatarMainBottomMargin();
          foreOne = false;
        }
        offsetX--;
      }
    });
    update();
  }

*/