import 'package:flutter/material.dart';
import 'package:freeman/controller/enemy_bird_controller.dart';

class EnemyBird extends StatelessWidget {
  EnemyBird({Key? key, this.cont}) : super(key: key);
  dynamic cont;
  @override
  Widget build(BuildContext context) {
    /* print("..00...${EnemyBirdContoller.wingState[0]}");
    print("..11...${EnemyBirdContoller.wingState[1]}");
    print("...22..${EnemyBirdContoller.wingState[2]}");
    print("...33..${EnemyBirdContoller.wingState[3]}");**/
    // EnemyBirdContoller().reInitializeWing();
    return Positioned(
      left: 300,
      bottom: 220,
      child: Container(
        //  color: Colors.green,
        height: 150,
        child: Stack(alignment: AlignmentDirectional.center, children: [
          Positioned(
              left: 33.333,
              top: 80,
              child: Image.asset("assets/images/wing.png",
                  width: cont.wingState[0])),
          Positioned(
              child: Image.asset("assets/images/bird.png", width: 100
                  // alignment: Alignment.center,
                  )),
          Positioned(
              left: 39,
              top: 17,
              child: Image.asset("assets/images/wing-top.png",
                  width: cont.wingState[3])),
          Positioned(
              left: 39,
              top: 35,
              child: Image.asset("assets/images/wing-top-2.png",
                  width: cont.wingState[2])),
          Positioned(
              left: 39,
              top: 80,
              child: Image.asset("assets/images/wing-bootom-2.png",
                  width: cont.wingState[1])),
          Positioned(
              left: 39,
              top: 82,
              child: Image.asset("assets/images/wing-bottom.png",
                  width: cont.wingState[0])),
          /*     Positioned(
              left: 39,
              top: 27.5,
              child: Image.asset("assets/images/wing.png", width: 26.6))*/
        ]),
      ),
    );
  }
}
