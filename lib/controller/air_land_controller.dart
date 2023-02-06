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
      return airLandBottomPosition + 15 - Move.offsetY;
    } else {
      return 135;
    }
  }

  refresh5() async {
    getCurrentElementIndex(element: airLand);
    //  scopeScreen();
    await Future.delayed(const Duration(milliseconds: 10), () {
      if (Move.forwod == true) {
        //  print("forward is true");
        update();
      }
      if (Move.back == true) {
        //  print("back  is true");
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
      Move.offsetY = Move.freemanPositionY - 135;
    } else {
      Move.offsetY = 0;
    }
    update();
  }

  testDealy() async {
    await Future.delayed(const Duration(seconds: 7), () {
      Move.offsetY = 50;
    });
  }

  void onInit() {
    refresh5();
    // TODO: implement onInit
    super.onInit();
  }
}
