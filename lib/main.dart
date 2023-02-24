import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freeman/controller/air_land_controller.dart';
import 'package:freeman/controller/character_controller.dart';
import 'package:freeman/controller/coins_controller.dart';
import 'package:freeman/controller/enemy_bird_controller.dart';
import 'package:freeman/controller/fireball.dart';
import 'package:freeman/controller/move.dart';
import 'package:freeman/controller/rudder_controller.dart';
import 'package:freeman/sections/air_and.dart';
import 'package:freeman/sections/character.dart';
import 'package:freeman/sections/coins.dart';
import 'package:freeman/sections/enemy_bird.dart';
import 'package:freeman/sections/fireball.dart';
import 'package:freeman/sections/hole.dart';
import 'package:freeman/sections/moving_land.dart';
import 'package:freeman/sections/rudder.dart';
import 'package:get/get.dart';
//import 'dart:async';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
          backgroundColor: Color(0xFF3b5557), body: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Move moveController = Get.put(Move(), permanent: false);
    FireBallController fireBallInstance =
        Get.put(FireBallController(), permanent: false);
    AirLandController airLandController =
        Get.put(AirLandController(), permanent: false);
    RudderController rudderController =
        Get.put(RudderController(), permanent: false);
    EnemyBirdContoller birdController =
        Get.put(EnemyBirdContoller(), permanent: false);

    CharacterController characterController =
        Get.put(CharacterController(), permanent: false);

    /*  CoinsController coinsController =
        Get.put(CoinsController(), permanent: false);*/
    return SizedBox(
      width: 9940,
      height: double.infinity,
      child: Stack(children: [
        Positioned(
            child: Positioned(
          left: 0,
          child: SizedBox(
            /* width: 720,
            height: 225,*/
            child: Image.asset(
              "assets/images/cave.png",
              fit: BoxFit.cover,
            ),
          ),
        )),
        GetBuilder<Move>(builder: (context) {
          return Positioned(
            left: -Move.offsetX,
            bottom: 0 - Move.offsetY,
            child: SizedBox(
              width: 9940,
              height: 720,
              child: Image.asset("assets/images/main-background.png",
                  fit: BoxFit.cover),
            ),
          );
        }),
        GetBuilder<Move>(builder: (context) {
          return MovingLand(
              offsetX: Move.offsetX, horizontalLand: Move.horizontalLand);
        }),
        GetBuilder<CharacterController>(builder: (context) {
          return Positioned(
              bottom: Move.freemanPositionY - Move.offsetY,
              left: Move.freemanPositionX,
              child: Character(controll: characterController));
        }),
        GetBuilder<FireBallController>(builder: (context) {
          return FireBall(
              moveDown: FireBallController.moveDown,
              fireBallBotoomPosition: FireBallController.fireBallBotoomPosition,
              fireBallCount: FireBallController.fireBallCount,
              fireBallLeftPosition: FireBallController.fireBallLeftPosition);
        }),
        GetBuilder<AirLandController>(builder: (context) {
          return AirLand(offsetX: Move.offsetX, offsetY: Move.offsetY);
        }),
        MoveButtons(
          moveController: moveController,
          airLandController: airLandController,
        ),
        GetBuilder<RudderController>(builder: (context) {
          return Rudder(offsetX: Move.offsetX);
        }),
        GetBuilder<Move>(builder: (context) {
          return Coin(collectionCoins: coins, listdata: Move.coinswidthValues);
        }),
        Positioned(
          right: 20,
          bottom: 20,
          child: ElevatedButton(
              onPressed: () {
                moveController.jumpAnime();
              },
              child: const Text("Jump")),
        ),
        GetBuilder<EnemyBirdContoller>(builder: (context) {
          return EnemyBird(cont: birdController);
        }),
        GetBuilder<Move>(builder: (context) {
          return Positioned(
              top: 70,
              left: 150,
              child: Container(width: 1, height: 150, color: Colors.red));
        }),
        GetBuilder<Move>(builder: (context) {
          return Positioned(
              top: 70,
              left: 196,
              child: Container(width: 1, height: 150, color: Colors.red));
        })

        /*  Positioned(
          left: 4662 - Move.offsetX + 100,
          bottom: 20,
          child: ElevatedButton(
              onPressed: () {
                moveController.updateFreemanPosition();
              },
              child: const Text("rePosition")),
        )*/
      ]),
    );
  }
}

/*
class Coin extends StatelessWidget {
  Coin({Key? key, this.collectionCoins}) : super(key: key);
  final List? collectionCoins;
  @override
  Widget build(BuildContext context) {
    int counterIndex = -1;
    return Stack(
        children: List.generate(
      collectionCoins!.length,
      (collectionIndex) => Positioned(
        //  duration: const Duration(milliseconds: 100),
        left: collectionCoins![collectionIndex]["left-position"] - Move.offsetX,
        bottom: collectionCoins![collectionIndex]["bottom-position"],
        child: Row(
            children: List.generate(
          collectionCoins![collectionIndex]['count'],
          (index) {
            counterIndex++;
            return SizedBox(
              width: 35,
              height: 35,
              child: Center(
                  child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Move.coinsColor[counterIndex]))),
            );
          },
        )),
      ),
    ));
  }
}
*/
/*
class Hole extends StatelessWidget {
  const Hole({Key? key, this.leftPosition, this.holeWidth}) : super(key: key);

  final double? leftPosition;
  final double? holeWidth;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      // duration: const Duration(seconds: 3),
      bottom: 0,
      left: leftPosition == null ? 600 : leftPosition,
      child: Container(
        width: holeWidth,
        height: 135,
        color: const Color(0xFFcacccb),
      ),
    );
  }
}
*/
class MoveButtons extends StatelessWidget {
  const MoveButtons({
    Key? key,
    required this.moveController,
    this.airLandController,
  }) : super(key: key);

  final Move moveController;
  final AirLandController? airLandController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 50,
        bottom: 20,
        child: Row(children: [
          GestureDetector(
              onPanStart: (details) {
                Move.back = true;
                moveController.toBack();
              },
              onPanEnd: (details) {
                Move.back = false;
              },
              child: const Icon(Icons.arrow_back_ios_outlined)),
          const SizedBox(width: 40),
          GestureDetector(
              onPanStart: (details) {
                Move.forwod = true;
                moveController.toForward();
              },
              onPanEnd: (details) {
                Move.forwod = false;
              },
              child: const Icon(Icons.arrow_forward_ios_outlined)),
        ]));
  }
}
