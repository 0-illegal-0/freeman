import 'package:flutter/material.dart';
import 'package:freeman/controller/move.dart';

class Loss extends StatelessWidget {
  const Loss({Key? key, this.posi, this.diamonCounter, this.title})
      : super(key: key);
  // final controll;
  final int? diamonCounter;
  final String? title;
  final double? posi;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double lossWidth = width / 2.4;
    return Positioned(
        right: width - posi! - 20,
        top: lossWidth / 14.4,
        child: Stack(
          children: [
            Image.asset("assets/images/game_ui.png", width: lossWidth),
            Positioned(
              left: width / 6.9,
              top: width / 8,
              child: SizedBox(
                width: 100,
                child: Center(
                  child: Text(
                    "$title",
                    textAlign: TextAlign.center,
                    style:
                        const TextStyle(fontSize: 20, color: Color(0xFFfeeaa6)),
                  ),
                ),
              ),
            ),
            Positioned(
              left: width / 6.0,
              top: width / 4.0,
              child: SizedBox(
                width: 70,
                child: Center(
                  child: Text(
                    "$diamonCounter",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, color: Colors.red),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
