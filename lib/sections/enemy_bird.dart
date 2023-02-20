import 'package:flutter/material.dart';
import 'package:freeman/controller/enemy_bird_controller.dart';

class EnemyBird extends StatelessWidget {
  EnemyBird({Key? key, this.cont}) : super(key: key);
  dynamic cont;
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: List.generate(
            enemyBirds.length, (index) => Bird(cont: cont, index: index)));
  }
}

class Bird extends StatelessWidget {
  const Bird({
    Key? key,
    required this.cont,
    this.index,
  }) : super(key: key);

  final dynamic cont;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: enemyBirds[index!]['left.position'],
      bottom: enemyBirds[index!]['bottom-position'],
      child: SizedBox(
        height: 150,
        child: Stack(alignment: AlignmentDirectional.center, children: [
          Positioned(
            left: 33.333,
            top: 82,
            child: Transform(
              transform: Matrix4.rotationY(0)..rotateX(cont.angle),
              child: Image.asset("assets/images/wing.png", width: 26.6),
            ),
          ),
          Positioned(child: Image.asset("assets/images/bird.png", width: 100)),
          Positioned(
              left: 39,
              top: 84,
              child: Transform(
                  transform: Matrix4.rotationY(0)..rotateX(cont.angle),
                  child: Image.asset("assets/images/wing-bottom.png",
                      width: 26.6))),
        ]),
      ),
    );
  }
}

const List enemyBirds = [
  {'left.position': 150.0, 'bottom-position': 220.0},
  {'left.position': 300.0, 'bottom-position': 240.0},
  {'left.position': 450.0, 'bottom-position': 200.0}
];
