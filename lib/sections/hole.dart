import 'package:flutter/material.dart';

class Hole extends StatelessWidget {
  const Hole({Key? key, this.offsetX, this.offsetY}) : super(key: key);
  final double? offsetX, offsetY;
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: List.generate(
            holePosition.length,
            (index) => Positioned(
                left: holePosition[index]['margin-left']! - offsetX! + 20,
                bottom: 0 - offsetY!,
                child: Container(
                    width: holePosition[index]['width'],
                    height: 147,
                    color: const Color(0xFF7d5d38)))));
  }
}

const List<Map<String, double>> holePosition = [
  {'margin-left': 250, 'width': 100},
  {'margin-left': 600, 'width': 90},
  {'margin-left': 1200, 'width': 550},
  //{'margin-left': 1200, 'width': 550},
];
