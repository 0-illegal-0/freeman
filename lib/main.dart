import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freeman/controller/air_land_controller.dart';
import 'package:freeman/controller/character_controller.dart';
import 'package:freeman/controller/enemy_bird_controller.dart';
import 'package:freeman/controller/fireball.dart';
import 'package:freeman/controller/important_note_controller.dart';
import 'package:freeman/controller/loss_controller.dart';
import 'package:freeman/controller/move.dart';
import 'package:freeman/controller/rudder_controller.dart';
import 'package:freeman/controller/stones_controller.dart';
import 'package:freeman/sections/air_and.dart';
import 'package:freeman/sections/character.dart';
import 'package:freeman/sections/coins.dart';
import 'package:freeman/sections/enemy_bird.dart';
import 'package:freeman/sections/fireball.dart';
import 'package:freeman/sections/hole.dart';
import 'package:freeman/sections/loss.dart';
import 'package:freeman/sections/moving_land.dart';
import 'package:freeman/sections/rudder.dart';
import 'package:freeman/sections/stone.dart';
import 'package:freeman/sections/top_bar.dart';
import 'package:freeman/widget/button.dart';
import 'package:get/get.dart';

import 'data/coins.dart';
import 'sections/screen_size_note.dart';
import 'widget/important_note.dart';
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
      debugShowCheckedModeBanner: false,
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
    double height = MediaQuery.of(context).size.height;
    Move moveController = Get.put(Move(width: width), permanent: false);
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

    StonesController stoneController =
        Get.put(StonesController(), permanent: false);

    ImportantNoteController importantNoteController =
        Get.put(ImportantNoteController(), permanent: false);

    print("This is height $height");
    print("This is width $width");
    return SizedBox(
      width: 9940,
      height: double.infinity,
      child: Stack(children: [
        Positioned(
          left: 0,
          child: SizedBox(
            child: Image.asset(
              "assets/images/cave.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
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
        GetBuilder<FireBallController>(builder: (context) {
          return FireBall(
              moveDown: FireBallController.moveDown,
              fireBallBotoomPosition: FireBallController.fireBallBotoomPosition,
              fireBallCount: FireBallController.fireBallCount,
              fireBallLeftPosition: FireBallController.fireBallLeftPosition);
        }),
        GetBuilder<StonesController>(builder: (context) {
          return Stone(
              moveDown: StonesController.moveDown,
              fireBallBotoomPosition: StonesController.fireBallBotoomPosition,
              fireBallCount: StonesController.fireBallCount,
              fireBallLeftPosition: StonesController.fireBallLeftPosition);
        }),
        GetBuilder<AirLandController>(builder: (context) {
          return AirLand(offsetX: Move.offsetX, offsetY: Move.offsetY);
        }),
        MoveButtons(
            moveController: moveController,
            airLandController: airLandController),
        GetBuilder<RudderController>(builder: (context) {
          return Rudder(offsetX: Move.offsetX);
        }),
        GetBuilder<Move>(builder: (context) {
          return Coin(
              collectionCoins: coins,
              listdata: Move.coinswidthValues,
              offsetY: Move.offsetY);
        }),
        GetBuilder<Move>(builder: (context) {
          return Loss(
              posi: Move.leftLossPosition,
              title: Move.rankStateTitle,
              diamonCounter: moveController.diamondCounter);
        }),
        GetBuilder<Move>(builder: (context) {
          return TopBar(controll: moveController, result: Move.result);
        }),
        GetBuilder<ImportantNoteController>(builder: (context) {
          return ImportantNote(color: ImportantNoteController.color);
        }),
        GetBuilder<CharacterController>(builder: (context) {
          return Positioned(
              bottom: Move.freemanPositionY - Move.offsetY,
              left: Move.freemanPositionX,
              child: Character(
                  controll: characterController, rotateY: Move.charachterY));
        }),
        Positioned(
          right: 20,
          bottom: 20,
          child: TextButton(
              onPressed: () {
                moveController.jumpAnime();
              },
              child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(172, 164, 177, 0.4)),
                  child: Image.asset("assets/images/jump-button.png",
                      width: 100))),
        ),
        GetBuilder<EnemyBirdContoller>(builder: (context) {
          return EnemyBird(cont: birdController);
        }),
        ScreenSizeNote(width: width, height: height)
      ]),
    );
  }
}
