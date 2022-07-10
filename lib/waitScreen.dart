import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weight/exercisePage.dart';

class WaitScreen extends StatefulWidget {
  Map exerciseData;
  int index;
  int dayNumber;
  WaitScreen(
      {required this.exerciseData,
      required this.index,
      required this.dayNumber});

  @override
  State<WaitScreen> createState() => _WaitScreenState();
}

class _WaitScreenState extends State<WaitScreen> {
  @override
  void initState() {
    countDownTimer();
    super.initState();
  }

  // @override
  // void dispose() {
  //   countDownTimer().dispose();
  //   super.dispose();
  // }

  int timerCount = 3;
  countDownTimer() async {
    for (int x = timerCount; x > 1; x--) {
      await Future.delayed(const Duration(seconds: 1)).then((_) {
        setState(() {
          timerCount -= 1;
        });
      });
    }
    if (timerCount == 1) {
      Get.to(() => ExercisePage(
          dayNumber: widget.dayNumber,
          exData: widget.exerciseData,
          exGif: widget.exerciseData["lottieFile"][widget.index],
          exName: widget.exerciseData["exerciseNames"][widget.index],
          exTime: widget.exerciseData["exerciseTime"][widget.index]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Lottie.asset('images/wait.json'),
            const SizedBox(
              height: 80,
            ),
            const Center(
              child: Text(
                'READY TO GO!',
                style: TextStyle(
                    color: Color.fromARGB(255, 51, 255, 163),
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150),
                  border: Border.all(
                      color: const Color.fromARGB(255, 51, 255, 163),
                      width: 5)),
              child: Center(
                child: Text(
                  timerCount.toString(),
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
