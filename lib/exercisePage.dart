import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight/congrats.dart';
import 'package:weight/homePage.dart';
import 'package:weight/main.dart';
import 'package:weight/playVideo.dart';
import 'package:weight/waitScreen.dart';

import 'choosePlan.dart';

class ExercisePage extends StatefulWidget {
  String exName;
  int exTime;
  String exGif;
  Map exData;
  int dayNumber;
  ExercisePage(
      {required this.exData,
      required this.dayNumber,
      required this.exGif,
      required this.exName,
      required this.exTime});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  int indexNo = 0;
  @override
  void initState() {
    countDownTimer();
    super.initState();
  }

  countDownTimer() async {
    if (widget.exTime == 30 || widget.exTime == 30) {
      for (int x = widget.exTime; x > 0; x--) {
        await Future.delayed(const Duration(seconds: 1)).then((_) {
          setState(() {
            widget.exTime -= 1;
          });
        });
      }
    }
    if (widget.exTime == 0 &&
        widget.exData['exerciseNames'].indexOf(widget.exName) <
            widget.exData['totalEx'] - 1) {
      SharedPreferences _sharedPreferences =
          await SharedPreferences.getInstance();
      _sharedPreferences.setBool(
          'Day ${widget.dayNumber} - $planNameAvaliable - ${widget.exName}',
          true);

      Get.to(() => WaitScreen(
            dayNumber: widget.dayNumber,
            exerciseData: widget.exData,
            index: widget.exData['exerciseNames'].indexOf(widget.exName) + 1,
          ));
    } else if (widget.exTime == 0 &&
        widget.exData['exerciseNames'].indexOf(widget.exName) ==
            widget.exData['totalEx'] - 1) {
      SharedPreferences _sharedPreferences =
          await SharedPreferences.getInstance();
      _sharedPreferences.setBool('Day ${widget.dayNumber} - $planName', true);
      for (var i = widget.dayNumber + 1; i < 30; i++) {
        _sharedPreferences.setBool('Day ${i} - $planName', false);
      }
      print('Day ${widget.dayNumber} - $planName');
      print(_sharedPreferences.getBool('Day ${widget.dayNumber} - $planName'));

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return Congrats();
      }));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Lottie.asset(
                widget.exGif,
              ),
              const SizedBox(
                height: 60,
              ),
              Text(
                widget.exName,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 50,
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
                  child: widget.exTime == 30 || widget.exTime == 40
                      ? Text(
                          '00:${widget.exTime.toString()}',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : widget.exTime == 16 || widget.exTime == 10
                          ? Text(
                              'x${widget.exTime.toString()}',
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text(
                              '00:${widget.exTime.toString()}',
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              widget.exTime == 16 || widget.exTime == 10
                  ? GestureDetector(
                      onTap: () async {
                        if (widget.exData['exerciseNames']
                                .indexOf(widget.exName) <
                            widget.exData['totalEx'] - 1) {
                          SharedPreferences _sharedPreferences =
                              await SharedPreferences.getInstance();
                          _sharedPreferences.setBool(
                              'Day ${widget.dayNumber} - $planNameAvaliable - ${widget.exName}',
                              true);
                          Get.to(() => WaitScreen(
                                dayNumber: widget.dayNumber,
                                exerciseData: widget.exData,
                                index: widget.exData['exerciseNames']
                                        .indexOf(widget.exName) +
                                    1,
                              ));
                        } else if (widget.exData['exerciseNames']
                                .indexOf(widget.exName) ==
                            widget.exData['totalEx'] - 1) {
                          SharedPreferences _sharedPreferences =
                              await SharedPreferences.getInstance();
                          _sharedPreferences.setBool(
                              'Day ${widget.dayNumber} - $planNameAvaliable',
                              true);

                          Timer(Duration(seconds: 30), () {
                            Get.to(() => Congrats());
                          });
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 51, 255, 163),
                            borderRadius: BorderRadius.circular(50)),
                        child: const Center(
                            child: Text(
                          'Done',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                    )
                  : Container(
                      // margin: const EdgeInsets.all(20),
                      // height: 50,
                      // width: MediaQuery.of(context).size.width,
                      // decoration: BoxDecoration(
                      //     color: const Color.fromARGB(255, 51, 255, 163),
                      //     borderRadius: BorderRadius.circular(50)),
                      // child: const Center(
                      //     child: Text(
                      //   'Skip',
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // )),
                      ),
              GestureDetector(
                onTap: () {
                  Get.to(() => PlayVideo(
                      videoUrl: 'https://www.youtube.com/watch?v=u3zgHI8QnqE',
                      exerciseName: widget.exName));
                },
                child: Container(
                  margin: const EdgeInsets.all(20),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 74, 74),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(
                      child: Text(
                    'Watch Video',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
