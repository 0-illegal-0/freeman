import 'package:flutter/material.dart';
import 'package:freeman/controller/move.dart';

class AirLand extends StatelessWidget {
  const AirLand({Key? key, this.offsetX, this.offsetY}) : super(key: key);
  final double? offsetX, offsetY;
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: List.generate(
            airLand.length,
            (index) => Positioned(
                bottom: airLand[index]['bottom-position'] - offsetY,
                left: airLand[index]['left-position'] - offsetX,
                child: Container(
                  width: airLand[index]['width'],
                  height: 15,
                  color: const Color(0xFF32a4a8),
                ))));
  }
}

const List airLand = [
  {"width": 250.0, "left-position": 3300.0, "bottom-position": 200.0},
  {"width": 250.0, "left-position": 3700.0, "bottom-position": 260.0},
  {"width": 250.0, "left-position": 4050.0, "bottom-position": 300.0},
  {"width": 250.0, "left-position": 4500.0, "bottom-position": 350.0}
];
