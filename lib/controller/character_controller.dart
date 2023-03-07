import 'package:freeman/controller/move.dart';
import 'package:get/get.dart';

class CharacterController extends GetxController {
  List<double> characterWidth = [0, 0, 0];
  double stopAnimeState = 80.0;
  double jumpeAnimeState = 0.0;
  static const double characterMainWidth = 46.0;
  static const double characterMainHeight = 70.0;
  int index = 0;

  resetVal() {
    for (var i = 0; i < characterWidth.length; i++) {
      if (i == index) {
        characterWidth[index] = 80.0;
      } else {
        characterWidth[i] = 0;
      }
    }
  }

  reInitializeWing() async {
    await Future.delayed(const Duration(milliseconds: 150), () {
      resetVal();
      if (index > characterWidth.length - 2) {
        index = 0;
      } else {
        index++;
      }
    });

    reInitializeWing();
    update();
  }

  walkingAnimation() async {
    await Future.delayed(const Duration(milliseconds: 150), () {});
    if (Move.jumpState == false) {
      for (var i = 0; i < characterWidth.length; i++) {
        characterWidth[i] = 0.0;
      }
      stopAnimeState = 0.0;
      jumpeAnimeState = 80.0;
    } else if (Move.forwod && Move.jumpState || Move.back && Move.jumpState) {
      stopAnimeState = 0.0;
      jumpeAnimeState = 0.0;
      resetVal();
      if (index > characterWidth.length - 2) {
        index = 0;
      } else {
        index++;
      }
    } else {
      for (var i = 0; i < characterWidth.length; i++) {
        characterWidth[i] = 0.0;
      }
      jumpeAnimeState = 0.0;
      stopAnimeState = 80.0;
    }
    walkingAnimation();
    update();
  }

  updateFunctions() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {
      if (Move.forwod == true) {
        update();
      }
      if (Move.back == true) {
        update();
      }
    });
    updateFunctions();
    update();
  }

  @override
  void onInit() {
    walkingAnimation();
    super.onInit();
  }
}
