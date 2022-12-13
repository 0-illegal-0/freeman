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
    print("This is OFFSET ++++++ $offsetX");
  }

  toBack() async {
    await Future.delayed(const Duration(seconds: 0), () async {
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

  forward() async {
    finalposition = holePosition[indexHoleList]['margin-left']! - offsetX;

    if (finalposition < holePosition[indexHoleList]['minimum-margin']! &&
        indexHoleList < holePosition.length - 1) {
      indexHoleList++;
    }
    checkFailState();
    await Future.delayed(const Duration(milliseconds: 1), () {
      offsetX++;
    });
    update();
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
    await Future.delayed(const Duration(milliseconds: 1), () {
      offsetX--;
    });
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
        jump = false;
        if (freemanPositionY > 135) {
          freemanPositionY--;
        } else {
          jump = true;
          jumpComplete = true;
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
    if (fail == false) {
      if (finalposition < 100 &&
          finalposition >
              holePosition[indexHoleList - trick]['minimum-margin']!.toInt() &&
          freemanPositionY == 135 &&
          freemanPositionY == 135 &&
          currentLandPosition > freemanPositionX + 25) {
        fail = true;
      }
    }
  }

  avatarForwardWithLand() {
    if (landState == true) {
      if (freemanPositionY == 135 &&
          currentLandPosition < freemanPositionX + 25) {
        freemanPositionX = currentLandPosition + avatarMove;
        avatarMoveState = true;
      }
      avatarMoveExecute();
    }
  }

  avatarBackWithLand() {
    if (landState == true) {
      if (freemanPositionY == 135 &&
          currentLandPosition + 150 > freemanPositionX + 25) {
        freemanPositionX = currentLandPosition + avatarMove;
        avatarMoveState = true;
      }
      print("This is Back");
      avatarMoveExecute();
    }
  }

  double avatarMove = 0;
  bool avatarMoveState = false;
  avatarMoveExecute() {
    if (avatarMoveState == true) {
      avatarMove++;
    }
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
    if (currentCointPositionX < 225 && currentCointPositionX > -100) {
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
        if (Move.offsetX - coinwidth <
                coins[coinCurrentIndex]['max-position'] &&
            Move.offsetX - coinwidth >
                coins[coinCurrentIndex]['min-position'] &&
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

  int checkLandDuration = 1000, currentLandIndex = 0;
  bool landState = false;

  horizontalLandeMove() async {
    await Future.delayed(Duration(milliseconds: checkLandDuration), () {
      if (offsetX > moveLands[currentLandIndex]['effective-range']!) {
        landState = true;
      } else {
        landState = false;
      }
    });
    horizontalLandeMove();
  }

  static double horizontalLand = 0.0;
  bool landRightMove = false;
  bool landLeftMove = true;
  String avatarState = "toRight";

  currentAvatarState() {
    if (freemanPositionX >
        holePosition[2]['margin-left']!.toInt() + 550 - offsetX) {
      avatarState = "toLeft";
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

  avatarWithLand() {
    if (freemanPositionY == 135 &&
        currentLandPosition < freemanPositionX + 25 &&
        currentLandPosition + 150 > freemanPositionX) {
      if (avatarState == "toRight") {
        freemanPositionX = currentLandPosition + avatarMove;
        avatarMoveState = true;
      } else {
        freemanPositionX = currentLandPosition + 125;
        avatarMoveState = true;
      }
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

  double get currentLandPosition {
    return moveLands[0]['margin-left']! - offsetX + horizontalLand;
  }

  @override
  void onInit() async {
    coinListener();
    horizontalLandeMove();
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
  {'margin-left': 1204, 'effective-range': 700},
//  {'margin-left': 600},
];
