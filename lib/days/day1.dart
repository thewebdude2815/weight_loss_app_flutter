import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight/waitScreen.dart';

import '../choosePlan.dart';
import '../main.dart';

class Day1 extends StatefulWidget {
  int dayNumber;
  List<String> exerciseNames;
  List<String> exerciseGifs;
  List<int> exerciseTime;
  int totalex;
  Map exerciseData;
  Day1(
      {Key? key,
      required this.dayNumber,
      required this.exerciseGifs,
      required this.exerciseNames,
      required this.exerciseTime,
      required this.totalex,
      required this.exerciseData})
      : super(key: key);

  @override
  State<Day1> createState() => _Day1State();
}

class _Day1State extends State<Day1> {
  List<Widget> viewExercises = [];

  Widget allExercises() {
    for (int i = 0; i <= widget.exerciseNames.length - 1; i++) {
      setState(() {
        viewExercises.add(ExerciseSmallWidget(
            exerciseName: widget.exerciseNames[i],
            exerciseTime: widget.exerciseTime[i],
            lottieFile: widget.exerciseGifs[i]));
      });
    }
    return Column(children: viewExercises);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    'Day ${widget.dayNumber}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/daysPic.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Instruction',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              planNameAvaliable == null
                                  ? planName
                                  : planNameAvaliable!.toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const Text(
                              'Level',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '68.1',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              'Kcal',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '5 mins',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              'Duration',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox()
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Exercises',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    allExercises()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 51, 255, 163),
        child: Text('Go!'),
        onPressed: () {
          Get.to(() => WaitScreen(
                dayNumber: widget.dayNumber,
                index: widget.exerciseNames.indexOf(widget.exerciseNames[0]),
                exerciseData: widget.exerciseData,
              ));
        },
      ),
    );
  }
}

class ExerciseSmallWidget extends StatelessWidget {
  String lottieFile;
  String exerciseName;
  int exerciseTime;
  ExerciseSmallWidget(
      {required this.exerciseName,
      required this.exerciseTime,
      required this.lottieFile});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Lottie.asset(lottieFile, height: 100),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exerciseName.toUpperCase(),
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              exerciseTime == 30 || exerciseTime == 40
                  ? '00:${exerciseTime.toString()}'
                  : 'x${exerciseTime.toString()}',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color.fromARGB(255, 51, 255, 163)),
            )
          ],
        )
      ],
    );
  }
}
