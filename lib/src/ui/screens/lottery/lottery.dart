import 'dart:math';

import 'package:financial_management/src/ui/screens/lottery/lottery_type.dart';
import 'package:flutter/material.dart';

class Lottery extends StatefulWidget {
  const Lottery({super.key});

  @override
  State<StatefulWidget> createState() => _LotteryState();
}

class _LotteryState extends State<Lottery> {
  List<Widget> listNumber = List.empty(growable: true);

  void getLoteryResult(LotteryType type) {
    listNumber.clear();
    var random = Random();
    List<int> randomNumbers = [];
    switch (type) {
      case LotteryType.max3d:
        randomNumbers.add(random.nextInt(999));
      case LotteryType.max3dpro:
        while (randomNumbers.length < 2) {
          randomNumbers.add(random.nextInt(999));
        }
      case LotteryType.max3dplus:
        while (randomNumbers.length < 2) {
          randomNumbers.add(random.nextInt(999));
        }
      case LotteryType.sixfivefive:
        while (randomNumbers.length < 6) {
          randomNumbers.add(random.nextInt(55));
        }
      case LotteryType.sixfourfive:
        while (randomNumbers.length < 6) {
          randomNumbers.add(random.nextInt(45));
        }
    }
    for (int i = 0; i < randomNumbers.length; i++) {
      listNumber.add(Padding(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            radius: 30,
            child: Text(randomNumbers[i].toString()),
          )));
    }

    setState(() {
      listNumber = listNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilledButton(
                    onPressed: () =>
                        {getLoteryResult(LotteryType.sixfivefive)},
                    child: const Text("6/55")),
                FilledButton(
                    onPressed: () =>
                        {getLoteryResult(LotteryType.sixfourfive)},
                    child: const Text("6/45")),
                FilledButton(
                    onPressed: () => {getLoteryResult(LotteryType.max3d)},
                    child: const Text("Max3D")),
                FilledButton(
                    onPressed: () => {getLoteryResult(LotteryType.max3dpro)},
                    child: const Text("Max3D Pro")),
                FilledButton(
                    onPressed: () => {getLoteryResult(LotteryType.max3dplus)},
                    child: const Text("Max3D +"))
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: listNumber,
                ))
          ],
        ));
  }
}
