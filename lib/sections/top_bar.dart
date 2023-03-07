import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:freeman/controller/move.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key, this.controll, this.result}) : super(key: key);
  final controll;
  final double? result;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Positioned(
      bottom: height / 1.24 + result!,
      left: 18,
      child: Row(children: [
        SizedBox(
          width: width * 0.40,
          child: Row(
            children: [
              Expanded(
                child: Stack(alignment: AlignmentDirectional.center, children: [
                  Positioned(
                      child: Container(
                          height: 40,
                          // width: 130,
                          //  margin: const EdgeInsets.only(left: 20, top: 5),
                          // color: const Color(0xFFcf9013),
                          decoration: const BoxDecoration(
                              color: Color(0xFFcf9013),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))))),

                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        "assets/images/diamond.png",
                        width: 35,
                      ),
                    ),
                  ),
                  /*   Positioned(
                    left: 60,
                    top: 4,
                    child: */
                  Text(controll.diamondCounter.toString(),
                      style: const TextStyle(fontSize: 22)),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.add_circle_outline_outlined,
                      size: 40,
                    ),
                  )
                  // ),
                ]),
              ),
              const SizedBox(width: 20, height: 40),
              Expanded(
                child: Stack(alignment: AlignmentDirectional.center, children: [
                  Positioned(
                      child: Container(
                          height: 40,
                          decoration: const BoxDecoration(
                              color: Color(0xFFcf9013),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))))),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        "assets/images/clock-icon.png",
                        width: 30,
                      ),
                    ),
                  ),
                  Text(" ${controll.time.toString()}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22)),
                ]),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
