import 'package:freeman/controller/move.dart';
import 'package:get/get.dart';

class EnemyBirdContoller extends GetxController {
  List<double> wingState = [0, 0, 0, 0];
  int index = 0;
  resetVal() {
    for (var i = 0; i < wingState.length; i++) {
      if (i == index) {
        wingState[index] = 26.6;
      } else {
        wingState[i] = 0;
      }
    }
  }

  reInitializeWing() async {
    resetVal();
    await Future.delayed(const Duration(milliseconds: 150), () {});
    if (index > wingState.length - 2) {
      index = 0;
    } else {
      index++;
    }
    reInitializeWing();
    update();
  }

  priVal() async {
    await Future.delayed(const Duration(milliseconds: 2000000), () {
      print("0 ${wingState[0]}");
      print("1 ${wingState[1]}");
      print("2 ${wingState[2]}");
      print("3 ${wingState[3]}");
      print("index ${index}");
    });
    priVal();
  }

  updateFunctions() async {
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

  @override
  void onInit() {
    //  updateFunctions();
    reInitializeWing();
    priVal();
    // TODO: implement onInit
    super.onInit();
  }
}
