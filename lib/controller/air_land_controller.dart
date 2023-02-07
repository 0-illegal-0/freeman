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
      return airLandBottomPosition + 16 - Move.offsetY;
    } else {
      return 135;
    }
  }

  bool avatarOnAirLand = false;
  avatarWithairLandState() {
    if (Move.freemanPositionY == airLandBottomPosition + 16 &&
        Move.freemanPositionX + 25 > airLandLeftPosition &&
        Move.freemanPositionX < airLandLeftPosition + airLandWidth) {
      avatarOnAirLand = true;
    }
  }

  dropFromAirLand() async {
    avatarWithairLandState();
    if (avatarOnAirLand == true) {
      if (Move.freemanPositionX + 25 < airLandLeftPosition ||
          Move.freemanPositionX > airLandLeftPosition + airLandWidth) {
        print("+++++");
        dropFromAirLandAnimate();
      }
    }
  }

  dropFromAirLandAnimate() async {
    await Future.delayed(const Duration(milliseconds: 1), () {
      if (Move.freemanPositionY > mainSiteAvatare) {
        print("------");
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
    dropFromAirLand();
    drop();
    getCurrentElementIndex(element: airLand);
    //scopeScreen();
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
                airLand[airLand.length - 1]['width']) {
      print("object");
      Move.offsetY = Move.freemanPositionY - 135;
    } else {
      Move.offsetY = 0;
    }
    update();
  }

  void onInit() {
    refresh5();
    // TODO: implement onInit
    super.onInit();
  }
}
