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
    print("This is width${width}");
    return GetBuilder<Move>(builder: (context) {
      return SizedBox(
        width: 9940,
        height: double.infinity,
        child: Stack(children: [
          /*  Hole(
              leftPosition:
                  moveController.holePosition + moveController.moveUnit),*/
          Positioned(
            bottom: Move.freemanPositionY,
            left: Move.freemanPositionX,
            child: Container(
              width: 25,
              height: 25,
              color: const Color(0xFF850310),
            ),
          ),
          Positioned(
            left: Move.surfaceMarginLeft,
            bottom: 0,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 9940,
                  height: 135,
                  child: Image.asset(
                    "assets/images/surface.png",
                    fit: BoxFit.cover,
                    //width: 7200,
                    //  height: 135,
                  ),
                )
                /*Container(
                // width: double.infinity,
                width: width,
                height: 135,
                color: const Color(0xFF1a6124),
              ),*/
                ),
          ),
          Transform.translate(
            offset: const Offset(300, 300),
            child: ElevatedButton(
                onPressed: () {
                  moveController._reset();
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
        ]),
      );
    });
  }
}

class Move extends GetxController {
  Move();
  double offsetMove = 0;
  static double surfaceMarginLeft = 0;

  static List<double> stagesWidth = [9940];

  _reset() {
    freemanPositionY = 135;
    freemanPositionX = 100;
    //holePosition = [250, 430, 600];
    moveUnit = 0;
    trickt = 0;
    indexHoleList = 0;
    finalposition = 0;
    fail = false;
    update();
    holeMove();
  }

  static double freemanPositionY = 135;
  static double freemanPositionX = 100;

  List<Map<String, double>> holePosition = [
    {'margin-left': 250, 'width': 70, 'minimumMargin': 55},
    {'margin-left': 430, 'width': 30, 'minimumMargin': 95},
    {'margin-left': 600, 'width': 90, 'minimumMargin': 35}
  ];
  double moveUnit = 0;
  int trickt = 0;
  int indexHoleList = 0;

  bool fail = false;

  double finalposition = 0;

  holeMove() async {
    /* if (holePosition[indexHoleList]['margin-left']! < 56 && indexHoleList < 2) {
      indexHoleList++;
    }*/
    await Future.delayed(const Duration(microseconds: 1), () {
      holePosition[0]['margin-left'] =
          holePosition[0]['margin-left']! - moveUnit;
      surfaceMarginLeft--;
      /* holePosition[1]['margin-left'] =
          holePosition[1]['margin-left']! - moveUnit;
      holePosition[2]['margin-left'] =
          holePosition[2]['margin-left']! - moveUnit;*/
    });

    trickt++;
    if (trickt == 1) {
      moveUnit = 1;
    }

    finalposition = holePosition[indexHoleList]['margin-left']! + moveUnit;

    if (finalposition < 100 &&
        finalposition > holePosition[indexHoleList]['minimumMargin']!.toInt() &&
        fail == false &&
        freemanPositionY == 135) {
      fail = true;
    }
    failAnimate();
    if (surfaceMarginLeft != -9230) {
      holeMove();
    } else {
      print("Compleat");
    }
    update();
  }

  failAnimate() {
    print("This is fail $fail");
    if (fail == true) {
      freemanPositionY = freemanPositionY - 1;
      freemanPositionX = freemanPositionX - 1;
    }
  }

  bool jump = true;
  bool jumpComplete = false;
  jumpAnime() async {
    await Future.delayed(const Duration(milliseconds: 1), () {
      if (jump == true && Move.freemanPositionY++ < 330) {
        Move.freemanPositionY++;
      } else {
        jump = false;
        if (Move.freemanPositionY > 135) {
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
    holeMove();
    super.onInit();
  }
}

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




/* [stages width] 
- first stage 10000
*/
