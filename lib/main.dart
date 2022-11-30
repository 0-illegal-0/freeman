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
                  ),
                )),
          ),
          Transform.translate(
            offset: Offset(-Move.offsetX, 0),
            child: Stack(
                children: List.generate(
              Move.holePosition.length,
              (index) => Hole(
                  holeWidth: Move.holePosition[index]['width'],
                  leftPosition: Move.holePosition[index][
                      'margin-left']! /* -
                      Move.offsetX */ //   moveController.moveUnit,
                  ),
            )),
          ),
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
              left: 50,
              bottom: 20,
              child: Row(children: [
                GestureDetector(
                    onPanStart: (details) {
                      Move.back = true;
                      moveController.toBehind();
                    },
                    onPanEnd: (details) {
                      Move.back = false;
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_outlined,
                    )),
                const SizedBox(width: 40),
                GestureDetector(
                    onPanStart: (details) {
                      Move.forwod = true;
                      moveController.executeForward();
                    },
                    onPanEnd: (details) {
                      Move.forwod = false;
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios_outlined,
                    )),
              ])),
          Positioned(
            right: 20,
            bottom: 20,
            child: ElevatedButton(
                onPressed: () {
                  moveController.jumpAnime();
                },
                child: const Text("Jump")),
          ),
          Positioned(
            right: 110,
            bottom: 20,
            child: ElevatedButton(
                onPressed: () {
                  moveController.moveBackground();
                },
                child: const Text("move")),
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
  static bool forwod = false;
  static bool back = false;
  static List<double> stagesWidth = [9940];

  static double offsetX = 0;
  moveBackground() {
    offsetX--;
    print(offsetX);
    update();
  }

  executeForward() async {
    await Future.delayed(const Duration(seconds: 0), () async {
      if (forwod == true && fail == false) {
        await toForward();
      } else {
        await failAnimate();
      }
    });
    if (forwod == true) {
      executeForward();
    }
  }

  toBehind() async {
    await Future.delayed(const Duration(seconds: 0), () async {
      if (back == true && fail == false) {
        await toBack();
      } else {
        await failAnimate();
      }
    });
    if (back == true) {
      toBehind();
    }
  }

  static double freemanPositionY = 135;
  static double freemanPositionX = 100;

  static List<Map<String, double>> holePosition = [
    {'margin-left': 250, 'width': 70, 'minimumMargin': 55},
    {'margin-left': 430, 'width': 30, 'minimumMargin': 95},
    {'margin-left': 600, 'width': 90, 'minimumMargin': 35},
  ];
  // double moveUnit = 1.0;
  int indexHoleList = 0;
  double finalposition = 0;

  toForward() async {
    finalposition = holePosition[indexHoleList]['margin-left']! - offsetX;

    if (finalposition < holePosition[indexHoleList]['minimumMargin']! &&
        indexHoleList < holePosition.length - 1) {
      indexHoleList++;
    }

    await Future.delayed(const Duration(milliseconds: 1), () {
      offsetX++;
    });

    checkFailState();

    update();
  }

  int trick = 0;
  bool lastStageHole = false;
  toBack() async {
    if (indexHoleList > 0 &&
        indexHoleList < holePosition.length &&
        holePosition[holePosition.length - 1]['margin-left']! - offsetX >
            freemanPositionX) {
      trick = 1;
      lastStageHole = false;
    } else {
      lastStageHole = true;
      trick = 0;
    }

    finalposition =
        holePosition[indexHoleList - trick]['margin-left']! - offsetX;
    checkFailState();

    if (finalposition >= freemanPositionX &&
        indexHoleList > 0 &&
        lastStageHole != true) {
      indexHoleList--;
    }
    print("this is trick $trick");
    await Future.delayed(const Duration(milliseconds: 1), () {
      offsetX--;
    });

    update();
  }

  bool fail = false;
  failAnimate() async {
    await Future.delayed(const Duration(milliseconds: 3), () {
      if (fail == true) {
        freemanPositionY = freemanPositionY - 2;
      }
    });
    if (freemanPositionY > -25 && fail == true) {
      failAnimate();
    }
    update();
  }

  bool jump = true;
  bool jumpComplete = false;

  jumpAnime() async {
    await Future.delayed(const Duration(milliseconds: 1), () {
      if (jump == true && freemanPositionY++ < 330) {
        freemanPositionY++;
      } else {
        jump = false;
        if (freemanPositionY > 135) {
          freemanPositionY--;
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
      checkFailState();
      failAnimate();
    }
  }

  checkFailState() {
    if (fail == false) {
      if (finalposition < 100 &&
          finalposition >
              holePosition[indexHoleList - trick]['minimumMargin']!.toInt() &&
          freemanPositionY == 135) {
        fail = true;
        print("finalposition $finalposition");
        print(
            "finalposition ${holePosition[indexHoleList]['minimumMargin']!.toInt()}");
        print("goooooooooooooo");
      }
    }
  }

  @override
  void onInit() async {
    // holeMove();
    // await execute();
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
