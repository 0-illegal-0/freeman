import 'package:flutter/material.dart';
import 'package:freeman/controller/coins_controller.dart';
import 'package:freeman/controller/move.dart';

class Coin extends StatelessWidget {
  Coin({Key? key, this.collectionCoins, this.listdata}) : super(key: key);
  final List? collectionCoins;
  final List? listdata;
  @override
  Widget build(BuildContext context) {
    int counterIndex = -1;
    return Stack(
        children: List.generate(
      collectionCoins!.length,
      (collectionIndex) => Positioned(
        // duration: const Duration(milliseconds: 100),
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
                  child: /*Image.asset("assets/images/diamond.png",
                      fit: BoxFit.cover)**/
                      Container(
                    width: listdata![counterIndex],
                    height: 30,
                    child: Image.asset("assets/images/diamond.png",
                        fit: BoxFit.cover),
                    /*   decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red)*/
                  ),
                ));
          },
        )),
      ),
    ));
  }
}
