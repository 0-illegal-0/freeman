import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImportantNoteController extends GetxController {
  @override
  static Color color = Colors.green;
  static String note = "Under Construction";
  changeColor() async {
    await Future.delayed(const Duration(seconds: 1), () {
      if (color == Colors.red) {
        color = Colors.green;
        note = "under construction";
      } else {
        color = Colors.red;
        note = "Not Finished";
      }
    });
    changeColor();
    update();
  }

  void onInit() {
    changeColor();

    // TODO: implement onInit
    super.onInit();
  }
}
