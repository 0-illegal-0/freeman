import 'package:freeman/controller/move.dart';
import 'package:get/get.dart';

class EnemyBirdContoller extends GetxController {
  List<double> wingState = [0, 0, 0, 0];
  int index = 0;
  double angle = 0.0;
  bool wingAnimationSwitch = true;

  wingAnimation() async {
    await Future.delayed(const Duration(milliseconds: 20), () {
      if (angle < 3.2 && wingAnimationSwitch == true) {
        angle = angle + 0.2;
      } else {
        wingAnimationSwitch = false;
        angle = angle - 0.2;
        if (angle < 0) {
          wingAnimationSwitch = true;
        }
      }
    });
    wingAnimation();
    update();
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
    wingAnimation();
    super.onInit();
  }
}
