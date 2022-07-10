import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight/choosePlan.dart';
import 'package:weight/days/day1.dart';
import 'package:weight/exerciseList.dart';

import 'loading_page.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  String? plan;
  HomePage({Key? key, this.plan}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool completed = false;

  Widget show30Days() {
    print('myResults - $myResults');
    List<Widget> days = [];
    if (myResults ==
        [
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null
        ]) {
      for (var i = 1; i < 31; i++) {
        days.add(DayWidget(
            exerciseData: exercises[i - 1],
            completed: daysList[i - 1]!,
            day: i,
            exerciseGifs: exercises[i - 1]['lottieFile'],
            exerciseNames: exercises[i - 1]['exerciseNames'],
            exerciseTime: exercises[i - 1]['exerciseTime'],
            totalex: exercises[i - 1]["totalEx"]));
      }
    } else {
      for (var i = 1; i < 31; i++) {
        days.add(DayWidget(
            exerciseData: exercises[i - 1],
            completed: myResults[i - 1]!,
            day: i,
            exerciseGifs: exercises[i - 1]['lottieFile'],
            exerciseNames: exercises[i - 1]['exerciseNames'],
            exerciseTime: exercises[i - 1]['exerciseTime'],
            totalex: exercises[i - 1]["totalEx"]));
      }
    }

    return Column(
      children: days,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFF0D263A),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: const Color(0xFF0D263A),
          title: const Text('Lose Weight'),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4), BlendMode.darken),
                        image: const AssetImage('images/exercise.jpg'),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        planNameAvaliable == ''
                            ? Text(
                                '$widget.plan'.toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                '$planNameAvaliable'.toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                        const Text(
                          '5-10 min a day',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                show30Days()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DayWidget extends StatelessWidget {
  int day;
  bool completed;
  List<String> exerciseNames;
  List<String> exerciseGifs;
  List<int> exerciseTime;
  int totalex;
  Map exerciseData;
  DayWidget(
      {Key? key,
      required this.completed,
      required this.day,
      required this.exerciseGifs,
      required this.exerciseNames,
      required this.exerciseTime,
      required this.totalex,
      required this.exerciseData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => Day1(
              exerciseData: exerciseData,
              dayNumber: day,
              exerciseGifs: exerciseGifs,
              exerciseNames: exerciseNames,
              exerciseTime: exerciseTime,
              totalex: totalex,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF01D1A1),
            borderRadius: BorderRadius.circular(10),
          ),
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Day ${day.toString()}',
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
              Container(
                height: 30,
                width: 90,
                decoration: BoxDecoration(
                  color: completed ? Colors.red : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: completed
                      ? const Text(
                          'Completed',
                          style: TextStyle(color: Colors.white),
                        )
                      : const Text('Start'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
