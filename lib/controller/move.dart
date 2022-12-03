import 'package:flutter/cupertino.dart';
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
      if (forwod == true && fail == false) {
        await forward();
      } else {
        await failAnimate();
      }
    });
    if (forwod == true) {
      toForward();
    }
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

  static List<Map<String, double>> holePosition = [
    {'margin-left': 250, 'width': 70, 'minimum-margin': 55},
    {'margin-left': 430, 'width': 30, 'minimum-margin': 95},
    {'margin-left': 600, 'width': 90, 'minimum-margin': 35},
  ];

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
          freemanPositionY == 135) {
        fail = true;
      }
    }
  }

  int duration = 10, coinCurrentIndex = 0;
  double get currentCointPositionX {
    return coins[coinCurrentIndex]['left-position'] - Move.offsetX;
  }

  coinListener() async {
    await Future.delayed(Duration(milliseconds: duration), () {
      if (currentCointPositionX < 710 && currentCointPositionX > -100) {
        print("===============");
        duration = 10;
      } else {
        duration = 1000;
      }
    });
    coinListener();

    //  print("This is duration $duration");
  }

  coinEffect() {}

  @override
  void onInit() async {
    coinListener();
    super.onInit();
  }
}
