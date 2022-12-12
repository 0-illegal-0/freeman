import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freeman/controller/move.dart';

class MovingLand extends StatelessWidget {
  const MovingLand({Key? key, this.offsetX, this.horizontalLand})
      : super(key: key);
  final double? offsetX, horizontalLand;
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: List.generate(
            moveLands.length,
            (index) => Positioned(
                left: moveLands[index]['margin-left']! -
                    offsetX! +
                    horizontalLand!,
                bottom: 120,
                child: Container(
                  width: 150,
                  height: 15,
                  color: const Color(0xFF113b80),
                ))));
  }
}
