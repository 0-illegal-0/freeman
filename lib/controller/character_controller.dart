import 'package:freeman/controller/move.dart';
import 'package:get/get.dart';

class CharacterController extends GetxController {
  // bool executeAngleUpdateForOnce = true;
  List<double> characterWidth = [0, 0, 0];
  double stopAnimeState = 80.0;
  double jumpeAnimeState = 0.0;
  int index = 0;
  resetVal() {
    for (var i = 0; i < characterWidth.length; i++) {
      print("index :- $index");
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

  double get poY {
    return Move.freemanPositionY;
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
      print("Y ${Move.freemanPositionY}");
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
    /*  if (Move.offsetX > 5250.0 && executeAngleUpdateForOnce) {
      executeAngleUpdateForOnce = false;
    }*/

    print("0::${characterWidth[0]}");
    print("1::${characterWidth[1]}");
    print("2::${characterWidth[2]}");
    /* print("3::${characterWidth[4]}");*/
    print("ـــــــــــــــــــــ");
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
    //  reInitializeWing();
    // updateFunctions();
    // TODO: implement onInit
    super.onInit();
  }
}
