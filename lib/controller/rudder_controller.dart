import 'package:freeman/sections/rudder.dart';
import 'package:get/get.dart';

import 'move.dart';

class RudderController extends GetxController {
  static double angle = 0.0;
  static double rudderMove = 0;
  static double rudderWidth = 60;
  static double rudderHeight = 60;

  static double get rudderPositionLeft {
    return rudder[0]["left-position"] -
        Move.offsetX -
        RudderController.rudderMove;
  }

  static double get topRudder {
    return rudder[0]["bottom-position"] + rudderHeight;
  }

  rudderAction() {
    if (rudderPositionLeft <= Move.freemanPositionX + 25 &&
            rudderPositionLeft > Move.freemanPositionX &&
            Move.freemanPositionY - Move.offsetY < topRudder ||
        rudderPositionLeft + rudderWidth >= Move.freemanPositionX &&
            rudderPositionLeft + rudderWidth < Move.freemanPositionX + 25 &&
            Move.freemanPositionY - Move.offsetY < topRudder) {
      print("Rudder Action");
    }
  }

  angleUpdate() async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      if (angle < 6.2) {
        angle = angle + 0.3;
      } else {
        angle = 0;
      }
      if (rudderMove > 500) {
        rudderMove = 0;
      } else {
        rudderMove = rudderMove + 4;
      }
    });
    angleUpdate();
    update();
  }

  updateFunctions() async {
    rudderAction();
    await Future.delayed(const Duration(milliseconds: 10), () {
      if (Move.forwod == true) {
        update();
      }
      if (Move.back == true) {
        update();
      }
    });
    updateFunctions();
  }

  void onInit() {
    angleUpdate();
    updateFunctions();
    // TODO: implement onInit
    super.onInit();
  }
}
