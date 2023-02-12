import 'package:freeman/controller/move.dart';
import 'package:freeman/sections/air_and.dart';
import 'package:get/get.dart';

// Important note there is bugg in getCurrentElementIndex function

class AirLandController extends GetxController {
  @override
  double elementSafeArea = 50;

  static int elementIndex = 0;

  static double get airLandLeftPosition {
    return airLand[elementIndex]['left-position'] - Move.offsetX;
  }

  static double get airLandWidth {
    return airLand[elementIndex]['width'];
  }

  static double get airLandBottomPosition {
    return airLand[elementIndex]['bottom-position'];
  }

  getCurrentElementIndex({List? element}) {
    if (airLandLeftPosition + airLandWidth + elementSafeArea <
            Move.freemanPositionX &&
        elementIndex < element!.length - 1) {
      elementIndex++;
    } else if (airLandLeftPosition - elementSafeArea >
            Move.freemanPositionX + 25 &&
        elementIndex > 0) {
      elementIndex--;
    }
  }

  static double get mainSiteAvatare {
    if (Move.freemanPositionX + 25 > airLandLeftPosition &&
        Move.freemanPositionX < airLandLeftPosition + airLandWidth) {
      return airLandBottomPosition + 15;
    } else if (Move.offsetY >= 233 &&
        airLand[airLand.length - 1]['left-position'] +
                airLand[airLand.length - 1]['width'] -
                Move.offsetX <
            Move.freemanPositionX + 25) {
      print("DONE");

      return 365;
    } else {
      return 135;
    }
  }

  bool avatarOnAirLand = false;
  avatarWithairLandState() {
    if (Move.freemanPositionY == airLandBottomPosition + 15 &&
        Move.freemanPositionX + 25 > airLandLeftPosition &&
        Move.freemanPositionX < airLandLeftPosition + airLandWidth) {
      avatarOnAirLand = true;
    }
  }

  dropFromAirLand() async {
    avatarWithairLandState();
    print("$avatarOnAirLand ................");
    if (avatarOnAirLand == true) {
      if (Move.freemanPositionX + 25 < airLandLeftPosition ||
          Move.freemanPositionX > airLandLeftPosition + airLandWidth ||
          airLand[airLand.length - 1]['left-position'] +
                  airLand[airLand.length - 1]['width'] -
                  Move.offsetX >
              Move.freemanPositionX) {
        dropFromAirLandAnimate();
      }
    }
  }

  dropFromAirLandAnimate() async {
    await Future.delayed(const Duration(milliseconds: 1), () {
      if (Move.freemanPositionY >
              mainSiteAvatare /*||
          Move.freemanPositionX >
              airLand[airLand.length - 1]['left-position'] +
                  airLand[airLand.length - 1]['width'] -
                  Move.offsetX*/
          ) {
        print("fooo");
        Move.freemanPositionY--;
        dropFromAirLandAnimate();
        avatarOnAirLand = false;
      }
    });
  }

  bool fail = false;
  failAnimate() async {
    await Future.delayed(const Duration(milliseconds: 3), () {
      if (fail == true) {
        Move.freemanPositionY = Move.freemanPositionY - 2;
      }
    });
    if (Move.freemanPositionY > -25 && fail == true) {
      failAnimate();
    }
    update();
  }

  drop() async {
    if (Move.freemanPositionX > 3700.0 - Move.offsetX &&
        Move.freemanPositionY < airLandBottomPosition) {
      fail = true;
      failAnimate();
    }
  }

  refresh5() async {
    print("offsetY ..... ${Move.offsetY}");
    print(
        " ${airLand[airLand.length - 1]['left-position'] + airLand[airLand.length - 1]['width'] - Move.offsetX} **** ${Move.freemanPositionX}");
    print(
        "airLandBottomPosition ${airLandBottomPosition + 15 - Move.offsetY} ------${Move.freemanPositionY - Move.offsetY} ");
    print(
        "offsetY ..... ${Move.freemanPositionY - Move.offsetY} +++ ${airLand[0]["bottom-position"] - Move.offsetY + 15}");
    dropFromAirLand();
    //drop();
    getCurrentElementIndex(element: airLand);
    scopeScreen();
    await Future.delayed(const Duration(milliseconds: 10), () {
      if (Move.forwod == true) {
        update();
      }
      if (Move.back == true) {
        update();
      }
    });

    refresh5();
  }

  scopeScreen() {
    if (Move.freemanPositionX + 25 >
                airLand[0]['left-position'] - Move.offsetX &&
            Move.freemanPositionX <
                airLand[airLand.length - 1]['left-position'] -
                    Move.offsetX +
                    airLand[airLand.length - 1][
                        'width'] /*&&
        Move.freemanPositionY >= airLand[0]["bottom-position"] + 15*/
        ) {
      scopeScreenAnimeUp();
    } else {
      scopeScreenAnimeDown();
    }
    update();
  }

  bool scopeForOneTime = true;
  scopeScreenAnimeUp() async {
    print("++++ ${110 * (elementIndex + 1)}");
    if (Move.offsetY < 110 * (elementIndex + 1)) {
      await Future.delayed(const Duration(milliseconds: 120), () {
        if (Move.offsetY < 110 * (elementIndex + 1)) {
          Move.offsetY++;
        }
        scopeScreenAnimeUp();
      });
    } else if (Move.offsetY > 110 * (elementIndex + 1)) {
      await Future.delayed(const Duration(milliseconds: 120), () {
        if (Move.offsetY > 110 * (elementIndex + 1)) {
          Move.offsetY--;
        }
        scopeScreenAnimeUp();
      });
    }
  }

  bool mainFloor = true;
  scopeScreenAnimeDown() async {
    if (Move.offsetY > 233 &&
        airLand[airLand.length - 1]['left-position'] +
                airLand[airLand.length - 1]['width'] -
                Move.offsetX <
            Move.freemanPositionX + 25) {
      await Future.delayed(const Duration(milliseconds: 10), () {
        if (Move.offsetY > 233) {
          mainFloor = false;
          Move.offsetY = Move.offsetY - 3;
        }
      });
    } else if (mainFloor == true) {
      Move.offsetY = 0;
    }
  }

  void onInit() {
    refresh5();
    // TODO: implement onInit
    super.onInit();
  }
}
