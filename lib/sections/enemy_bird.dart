import 'package:flutter/material.dart';
import 'package:freeman/controller/enemy_bird_controller.dart';
import 'package:freeman/controller/move.dart';

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
      left: enemyBirds[index!]['left-position'] -
          cont.bombTopValues[index]['position-left'] -
          Move.offsetX,
      bottom: 0,
      child: SizedBox(
        height: 360,
        width: EnemyBirdContoller.birdWidth,
        child: Stack(children: [
          Positioned(
              bottom: enemyBirds[index!]['bottom-position'] -
                  cont.bombTopValues[index]['position-bottom'],
              left: 35.0,
              child: Image.asset("assets/images/rocket-fire.png",
                  width:
                      10) /*Container(
                width: 10,
                height: 10,
                color: Colors.yellow,
                alignment: Alignment.center,
              )*/
              ),
          Positioned(
            left: 26.666,
            bottom: enemyBirds[index!]['bottom-position'] - 50,
            child: Transform(
              transform: Matrix4.rotationY(0)..rotateX(cont.angle),
              child: Image.asset("assets/images/wing.png", width: 22.0),
            ),
          ),
          Positioned(
              bottom: enemyBirds[index!]['bottom-position'],
              child: Image.asset("assets/images/bird.png", width: 80)),
          Positioned(
              left: 31.2,
              bottom: enemyBirds[index!]['bottom-position'] - 50,
              child: Transform(
                  transform: Matrix4.rotationY(0)..rotateX(cont.angle),
                  child: Image.asset("assets/images/wing-bottom.png",
                      width: 22.0))),
        ]),
      ),
    );
  }
}

const List enemyBirds = [
  {'left-position': 6600.0, 'bottom-position': 300.0},
  {'left-position': 7000.0, 'bottom-position': 310.0},
  {'left-position': 7400.0, 'bottom-position': 330.0},
  {'left-position': 7600.0, 'bottom-position': 330.0},
  {'left-position': 7700.0, 'bottom-position': 330.0}
];
