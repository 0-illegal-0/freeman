import 'package:freeman/controller/move.dart';
import 'package:get/get.dart';

class AirLandController extends GetxController {
  @override
  dynamic x = 9;
  refresh5() async {
    await Future.delayed(Duration(milliseconds: 10), () {
      if (Move.forwod == true) {
        print("forward is true");
        update();
      }
      if (Move.back == true) {
        print("back  is true");
        update();
      }
    });

    refresh5();
  }

  void onInit() {
    refresh5();
    // TODO: implement onInit
    super.onInit();
  }
}
