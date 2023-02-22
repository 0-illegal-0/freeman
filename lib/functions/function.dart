import 'package:freeman/controller/move.dart';

class GetCurrentIndex {
  double elementSafeArea = 50;
  int elementIndex = 0;

  getCurrentElementIndex(
      {List? element, double? elementLeftPosition, double? elementWidth}) {
    if (elementLeftPosition! + elementWidth! + elementSafeArea <
            Move.freemanPositionX &&
        elementIndex < element!.length - 1) {
      elementIndex++;
    } else if (elementLeftPosition - elementSafeArea >
            Move.freemanPositionX + 80 &&
        elementIndex > 0) {
      elementIndex--;
    }
  }
}

  /*
finalposition +
                    holePosition[getCurrentIndexInstance.elementIndex]['width']!
                        .toInt() >
                freemanPositionX + CharacterController.characterMainWidth
  */
