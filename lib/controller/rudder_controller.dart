import 'package:freeman/sections/rudder.dart';
import 'package:get/get.dart';

import 'move.dart';

class RudderController extends GetxController {
  static double angle = 0.0;
  /*static double rudderMove = 0;
  static double rudderMove2 = 0;*/
  static double rudderWidth = 60;
  static double rudderHeight = 60;
  static List<int> rudderMove = [0, 0, 0, 0];

  static double rudderPositionLeft({int? index}) {
    return rudder[index!]["left-position"] - Move.offsetX - rudderMove[index];
  }

  static double topRudder({index}) {
    return rudder[index]["bottom-position"] + rudderHeight;
  }

  static double northernEdge({index}) {
    return (rudder[index]["left-position"]) - 4762 + rudderWidth;
  }

  bool executeAnimateLossPosition = false;
  rudderAction({index}) {
    if (rudderPositionLeft(index: index) <= Move.freemanPositionX + 25 &&
            rudderPositionLeft(index: index) > Move.freemanPositionX &&
            Move.freemanPositionY - Move.offsetY < topRudder(index: index) ||
        rudderPositionLeft(index: index) + rudderWidth >=
                Move.freemanPositionX &&
            rudderPositionLeft(index: index) + rudderWidth <
                Move.freemanPositionX + 25 &&
            Move.freemanPositionY - Move.offsetY < topRudder(index: index)) {
      Move.rankStateTitle = "Game Over";
      Move.fail = true;
      Move.result = 500;
      if (executeAnimateLossPosition == false) {
        executeAnimateLossPosition = true;
        animateLossPosition();
      }
    }
  }

  dynamic cont = Move(width: 720);
  animateLossPosition() async {
    print("+++++");
    await Future.delayed(const Duration(milliseconds: 5), () {
      Move.leftLossPosition = Move.leftLossPosition! + 5;
    });
    if (Move.leftLossPosition! < cont.width! * 0.67) {
      print("....${Move.leftLossPosition}");

      animateLossPosition();
    }
    update();
  }

  angleUpdate({int? index}) async {
    await Future.delayed(const Duration(milliseconds: 50), () {
      if (angle < 6.2) {
        angle = angle + 0.1;
      } else {
        angle = 0;
      }
      if (rudderMove[index!] > northernEdge(index: index)) {
      } else {
        rudderMove[index] = rudderMove[index] + 4;
      }
    });
    if (rudderMove[index!] < northernEdge(index: index)) {
      angleUpdate(index: index);
    } else {
      executeRudderFailForOnce = false;
      rudderFail(index);
      /*  rudderFail(1);
      rudderFail(2);
      rudderFail(3);*/
      //   }
    }

    update();
  }

  bool executeRudderFailForOnce = true;
  static List<double> moveRudderToBottom = [0, 0, 0, 0];
  rudderFail(index) async {
    if (moveRudderToBottom[index] < 192 &&
        rudderMove[index!] >= northernEdge(index: index)) {
      await Future.delayed(const Duration(milliseconds: 20), () {
        moveRudderToBottom[index] = moveRudderToBottom[index] + 2;
      });
    }
    if (moveRudderToBottom[index] < 192) {
      rudderFail(index);
    }

    update();
  }

  bool executeAngleUpdateForOnce = true;
  updateFunctions() async {
    if (Move.offsetX > 5250.0 && executeAngleUpdateForOnce) {
      executeAngleUpdateForOnce = false;
      angleUpdate(index: 0);
      angleUpdate(index: 1);
      angleUpdate(index: 2);
      angleUpdate(index: 3);
    }
    rudderAction(index: 0);
    rudderAction(index: 1);
    rudderAction(index: 2);
    rudderAction(index: 3);
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
    updateFunctions();
    // TODO: implement onInit
    super.onInit();
  }
}
