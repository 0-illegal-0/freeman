import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freeman/controller/air_land_controller.dart';
import 'package:freeman/controller/character_controller.dart';
import 'package:freeman/controller/enemy_bird_controller.dart';
import 'package:freeman/controller/loss_controller.dart';
import 'package:freeman/functions/function.dart';
import 'package:freeman/main.dart';
import 'package:freeman/sections/air_and.dart';
import 'package:freeman/sections/hole.dart';
import 'package:get/get.dart';

import '../data/coins.dart';
import '../data/move_land.dart';

class Move extends GetxController {
  Move({this.width});
  double offsetMove = 0;
  static double surfaceMarginLeft = 0;
  static bool forwod = false;
  static bool back = false;
  static List<double> stagesWidth = [9940];
  static double offsetX = 0, offsetY = 0;
  static double result = 0;
  static double charachterY = 0;

  toForward() async {
    charachterY = 0;
    rankState();
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
  }

  toBack() async {
    charachterY = 3.15;
    rankState();
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

  int time = 500;
  timer() async {
    await Future.delayed(const Duration(seconds: 1), () {
      time--;
    });
    if (time > 0) {
      timer();
    }
    update();
  }

  static double freemanPositionY = 135;
  static double freemanPositionX = 133;

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

  static bool fail = false;
  static String rankStateTitle = "";
  bool executeAnimateLossPosition = false;
  //FailedController failedControllerInstance = FailedController(width: 720);
  rankState() async {
    if (fail == true) {
      rankStateTitle = "Game Over";
      result = 500;
    } else {
      rankStateTitle = "Win";
    }
    if (fail == true && executeAnimateLossPosition == false) {
      executeAnimateLossPosition = true;
      animateLossPosition();
    }
    update();
  }

  final double? width;
  //final bool? fail;
  static double? leftLossPosition = 0;

  animateLossPosition() async {
    await Future.delayed(const Duration(milliseconds: 5), () {
      leftLossPosition = leftLossPosition! + 5;
    });
    if (leftLossPosition! < width! * 0.67) {
      animateLossPosition();
    }
    update();
  }

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
      if (jump == true && freemanPositionY++ - offsetY < 290 && fail == false) {
        freemanPositionY++;
      } else {
        jump = false;
        {
          if (freemanPositionY > AirLandController.mainSiteAvatare &&
              fail == false) {
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
    if (Move.offsetX < minIndexPosition && coinCurrentIndex > 0) {
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

  static const double coinRightGap = 10.0;
  static const double coinLeftGap = 20.0;
  static const double mainCoinWidth = 35.0;
  int finalCurrentDiamondIndex = 0, diamondIndex = 0;
  int diamondCounter = 0;
  coinEffect() async {
    double coinwidth = 0;
    if (coinCurrentIndex > diamondIndex) {
      finalCurrentDiamondIndex =
          finalCurrentDiamondIndex + collectionIndexCount;
      diamondIndex++;
    } else if (coinCurrentIndex < diamondIndex) {
      finalCurrentDiamondIndex =
          finalCurrentDiamondIndex - coins[coinCurrentIndex]['count'] as int;
      diamondIndex--;
    }
    await Future.delayed(const Duration(milliseconds: 10), () {
      for (var i = 0; i < currentCointCount; i++) {
        if (Move.freemanPositionX <
                coins[coinCurrentIndex]['left-position'] -
                    Move.offsetX +
                    mainCoinWidth +
                    coinwidth -
                    coinRightGap &&
            Move.freemanPositionX + CharacterController.characterMainWidth >
                coins[coinCurrentIndex]['left-position'] +
                    coinwidth -
                    Move.offsetX -
                    coinLeftGap &&
            Move.freemanPositionY - offsetY >
                coins[coinCurrentIndex]['bottom-position'] - 25 - offsetY &&
            Move.freemanPositionY - offsetY <
                coins[coinCurrentIndex]['bottom-position'] + 35 - offsetY) {
          if (coinswidthValues[i + finalCurrentDiamondIndex] != 0.0) {
            coinswidthValues[i + finalCurrentDiamondIndex] = 0.0;
            diamondCounter++;
          }
        }
        coinwidth = coinwidth + mainCoinWidth;
      }
    });
    if (currentCointPositionX < 225 && currentCointPositionX > -100) {
      coinEffect();
    } else {
      coinListener();
    }
    update();
  }

  static List<double> coinswidthValues = [];
  createCoinswidthValues() {
    for (var i = 0; i < 999; i++) {
      coinswidthValues.add(30.0);
    }
  }

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
    timer();
    createCoinswidthValues();
    coinListener();
    landNoveEffect();
    super.onInit();
  }
}
