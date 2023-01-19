import 'package:flutter/material.dart';
import 'package:freeman/controller/move.dart';

class Barrier extends StatelessWidget {
  const Barrier({Key? key, this.offsetX}) : super(key: key);
  final double? offsetX;
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: List.generate(
            barriers.length,
            (index) => Positioned(
                  left: barriers[index]['margin-left']! - offsetX!,
                  bottom: barriers[index]['margin-bottom'],
                  child: Container(
                    width: 200,
                    height: barriers[index]['height']!,
                    color: const Color(0xFF011c47),
                  ),
                )));
  }
}
