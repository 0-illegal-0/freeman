import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          backgroundColor: Color(0xFFcacccb), body: MyHomePage()),
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

    return GetBuilder<Move>(builder: (context) {
      return Stack(children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            // width: double.infinity,
            width: width,
            height: 145,
            color: const Color(0xFF1a6124),
          ),
        ),
        Hole(leftPosition: moveController.holePosition),
        Positioned(
          bottom: Move.freemanPositionY,
          left: Move.freemanPositionX,
          child: Container(
            width: 25,
            height: 25,
            color: const Color(0xFF850310),
          ),
        ),
        Transform.translate(
          offset: const Offset(300, 300),
          child: ElevatedButton(
              onPressed: () {
                moveController._AnimatedPhysicalModel();
              },
              child: const Text("Reset")),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: ElevatedButton(
              onPressed: () {
                moveController.jumpAnime();
              },
              child: const Text("Jump")),
        )
      ]);
    });
  }
}

class Move extends GetxController {
  Move();
  double offsetMove = 0;

  _AnimatedPhysicalModel() {
    freemanPositionY = 145;
    freemanPositionX = 100;
    holePosition = 600;
    moveUnit = 0;
    trickt = 0;

    fail = false;
    update();
    holeMove();
  }

  static double freemanPositionY = 145;
  static double freemanPositionX = 100;

  double holePosition = 200;
  double moveUnit = 0;
  int trickt = 0;

  bool fail = false;

  holeMove() async {
    await Future.delayed(const Duration(milliseconds: 1), () {
      holePosition = holePosition - moveUnit;
    });

    trickt++;
    if (trickt == 20) {
      moveUnit = 1;
    }

    if (holePosition < 100 && holePosition > 55 && fail == false) {
      fail = true;
    }
    failAnimate();
    if (holePosition != -120) {
      holeMove();
    } else {
      print("Compleat");
    }
    update();
  }

  failAnimate() {
    if (fail == true) {
      freemanPositionY = freemanPositionY - 1;
      freemanPositionX = freemanPositionX - 1;
    }
  }

  bool jump = true;
  bool jumpComplete = false;
  jumpAnime() async {
    await Future.delayed(const Duration(microseconds: 999), () {
      if (jump == true && Move.freemanPositionY++ < 330) {
        print("----ToTop----- ${Move.freemanPositionY}");
        Move.freemanPositionY++;
      } else {
        print("----ToBottom-----");
        jump = false;
        if (Move.freemanPositionY-- > 146) {
          Move.freemanPositionY--;
        } else {
          jump = true;
          jumpComplete = true;
        }
      }
      update();
    });
    if (jumpComplete == false) {
      jumpAnime();
    } else {
      jumpComplete = false;
    }
  }

  @override
  void onInit() {
    // holeMove();
    super.onInit();
  }
}

class Hole extends StatelessWidget {
  const Hole({Key? key, this.leftPosition}) : super(key: key);

  final double? leftPosition;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      // duration: const Duration(seconds: 3),
      bottom: 0,
      left: leftPosition == null ? 600 : leftPosition,
      child: Container(
        width: 70,
        height: 145,
        color: const Color(0xFFcacccb),
      ),
    );
  }
}

class ForTest3 extends GetxController {
  AnimationController? animeController;
  dynamic anime;
  execute(This) {
    animeController =
        AnimationController(vsync: This, duration: Duration(seconds: 5));
    anime = Tween(begin: 600.0, end: -200.0).animate(animeController!)
      ..addStatusListener((status) {
        //  print(status);
      })
      ..addListener(() {
        print(anime!.value);
        update();
      });
    animeController!.forward();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
