import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freeman/main.dart';
import 'package:get/get.dart';

class Move extends GetxController {
  Move();
  double offsetMove = 0;
  static double surfaceMarginLeft = 0;
  static bool forwod = false;
  static bool back = false;
  static List<double> stagesWidth = [9940];
  static double offsetX = 0;

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
      toForward();
    }
    //  print("This is OFFSET ++++++ $offsetX");
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
  static double freemanPositionX = 100;

  int indexHoleList = 0;
  double finalposition = 0;
  bool avatarWithBarrierState = false;

  bool foreOne = true;

  forward() async {
    finalposition = holePosition[indexHoleList]['margin-left']! - offsetX;

    if (finalposition < holePosition[indexHoleList]['minimum-margin']! &&
        indexHoleList < holePosition.length - 1) {
      indexHoleList++;
    }
    checkFailState();
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

        //avatarWithBarrierState = false;
        offsetX++;
      }
    });
    update();
  }

  avatarMainBottomMargin() async {
    if (freemanPositionY > 135 && avatarWithBarrierState == true) {
      await Future.delayed(const Duration(milliseconds: 3), () {
        freemanPositionY = freemanPositionY - 1;
      });
      avatarMainBottomMargin();
      print("++++++ $freemanPositionY ++++++");
    } else {
      avatarWithBarrierState = false;
    }
  }

  int trick = 0;
  bool lastStageHole = false;
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
    await Future.delayed(const Duration(milliseconds: 1), () async {
      if (barriers[0]['margin-left']! - offsetX <= freemanPositionX + 25 &&
          barriers[0]['margin-left']! - offsetX + 200 > freemanPositionX) {
        if (freemanPositionY >= 235) {
          offsetX--;
          avatarWithBarrierState = true;
        }
      } else {
        await avatarMainBottomMargin();
        //avatarWithBarrierState = false;
        offsetX--;
      }
    });
    /*   await Future.delayed(const Duration(milliseconds: 1), () {
      offsetX--;
    });*/
    update();
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

  jumpAnime() async {
    await Future.delayed(const Duration(milliseconds: 1), () {
      if (jump == true && freemanPositionY++ < 290) {
        freemanPositionY++;
      } else {
        print("+++235 jump +++");
        jump = false;
        if (avatarWithBarrierState == true) {
          print("+++235 jump after +++");
          if (freemanPositionY > 235) {
            freemanPositionY--;
          } else {
            jump = true;
            jumpComplete = true;
          }
        } else {
          print("+++135 jump +++");
          if (freemanPositionY > 135) {
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
                    holePosition[indexHoleList - trick]['width']!.toInt() +
                    25 &&
            freemanPositionY == 135) {
          fail = true;
        }
      }
    } else {
      if (fail == false) {
        if (freemanPositionX > finalposition &&
                avatarMoveState != true &&
                freemanPositionY == 135 &&
                currentLandPosition > freemanPositionX + 25 &&
                finalposition >
                    freemanPositionX -
                        holePosition[indexHoleList - trick]['width']!.toInt() +
                        25 ||
            freemanPositionY == 139 &&
                avatarMoveState == true &&
                currentLandPosition > freemanPositionX + 25 ||
            freemanPositionX > currentLandPosition + 150 &&
                freemanPositionX + 25 <
                    finalposition +
                        holePosition[indexHoleList - trick]['width']!.toInt() &&
                freemanPositionY == 135) {
          print(
              "this is holePosition ${holePosition[indexHoleList - trick]['width']!.toInt()}");
          print("this is freemanPositionX $freemanPositionX");
          print("this is currentLandPosition ${currentLandPosition}");
          print("this is avatarMove $avatarMove");
          print('This is drop');
          fail = true;
        }
      }
    }
  }

//----------------------------- Coin ---------------------------
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
            Move.freemanPositionX + 25 >
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

// ----------------------Move Land----------------------

  int checkLandDuration = 1000, currentLandIndex = 0;
  bool landState = false;

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
      print("This is landState ++++++ $landState");
    }
  }

  static double horizontalLand = 0.0;
  bool landRightMove = false;
  bool landLeftMove = true;
  String avatarState = "toRight";

  currentAvatarState() {
    if (Move.freemanPositionX + 25 >
        holePosition[2]['margin-left']!.toInt() + 550 - Move.offsetX) {
      avatarState = "toLeft";
    } else {
      avatarState = "toRight";
    }
  }

  landNoveEffect() async {
    await Future.delayed(const Duration(milliseconds: 10), () {
      if (landRightMove == false) {
        landToRight();
        avatarWithLand();
      } else {
        avatarWithLand();
        landToleft();
      }
    });
    landNoveEffect();
    update();
  }

  bool testPlus = true;
  double testDouble = 2;
  avatarWithLand() {
    //  print("this is avatarMoveState $avatarMoveState");
    if (avatarMoveState == false &&
        Move.freemanPositionY == 135 &&
        Move.freemanPositionX + 25 > currentLandPosition &&
        Move.freemanPositionX < currentLandPosition + 150 &&
        Move.freemanPositionX > finalposition &&
        Move.freemanPositionX <
            finalposition +
                holePosition[indexHoleList - trick]['width']!.toInt()) {
      //  print("+++4+++++");
      if (landRightMove == false) {
        avatarMoveState = true;
        Move.freemanPositionX = Move.freemanPositionX + testDouble;
      } else if (landRightMove != false) {
        Move.freemanPositionX = Move.freemanPositionX - testDouble;
        avatarMoveState = true;
      }
    } else if (Move.freemanPositionY == 135 &&
        currentLandPosition < Move.freemanPositionX + 25 &&
        currentLandPosition + 150 > Move.freemanPositionX &&
        avatarState == "toRight") {
      if (landRightMove == false) {
        //   print("...1....");
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
                holePosition[indexHoleList - trick]['width']!.toInt() &&
        Move.freemanPositionX + 25 >
            finalposition +
                holePosition[indexHoleList - trick]['width']!.toInt()) {
      //  print("---2--");

      if (landRightMove == false && avatarMoveState == true) {
        Move.freemanPositionX = Move.freemanPositionX + testDouble;
      } else if (landRightMove != false) {
        Move.freemanPositionX = Move.freemanPositionX - testDouble;
        avatarMoveState = true;
      }
    } else if (avatarMoveState == true && Move.freemanPositionY == 135) {
      //   print("---3--");
      if (landRightMove == false && avatarMoveState == true) {
        Move.freemanPositionX = Move.freemanPositionX + testDouble;
      } else if (landRightMove != false && horizontalLand < 394.0) {
        Move.freemanPositionX = Move.freemanPositionX - testDouble;
        avatarMoveState = true;
      }
    } else {
      //  print("+++else+++++");
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
    finalposition = holePosition[indexHoleList]['margin-left']! - offsetX;
    if (Move.freemanPositionX >
        finalposition + holePosition[indexHoleList - trick]['width']!.toInt()) {
      avatarMoveState = false;
      print("33333");
    }
    if (landState == true) {
      if (Move.freemanPositionY == 135 &&
          currentLandPosition < Move.freemanPositionX + 25 &&
          currentLandPosition + 150 > Move.freemanPositionX + 25) {
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
    finalposition = holePosition[indexHoleList]['margin-left']! - offsetX;
    if (Move.freemanPositionX + 25 < finalposition) {
      avatarMoveState = false;
      print("33333");
    }
    if (landState == true && avatarMoveState == true) {
      if (Move.freemanPositionY == 135 &&
          currentLandPosition + 150 > Move.freemanPositionX + 25) {
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

  //   ------------------------ Barrier -----------------------

  @override
  void onInit() async {
    coinListener();
    landNoveEffect();
    super.onInit();
  }
}

const List<Map<String, double>> holePosition = [
  {'margin-left': 250, 'width': 70, 'minimum-margin': 55},
  {'margin-left': 600, 'width': 90, 'minimum-margin': 35},
  {'margin-left': 1200, 'width': 550, 'minimum-margin': -425},
];

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
//  {'margin-left': 600},
];

const List<Map<String, double>> barriers = [
  {'margin-left': 2050, 'height': 100, 'margin-bottom': 135},
//  {'margin-left': 600},
];
