import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight/choosePlan.dart';
import 'package:weight/homePage.dart';

import 'main.dart';

List<bool?> myResults = [];

class LoadingPage extends StatefulWidget {
  String? plan;
  LoadingPage({Key? key, this.plan}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool loading = false;

  @override
  void initState() {
    changeBool();
    Timer(Duration(seconds: 2), () {
      Get.to(() => HomePage(
            plan: widget.plan,
          ));
    });
    super.initState();
  }

  changeBool() async {
    var done = await getDoneDays();
    print('DaysList - $daysList');
    print('done - $done');
    setState(() {
      myResults = done;
    });
  }

  getDoneDays() async {
    List<bool?> checkComplete = [];

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    for (var i = 1; i < 31; i++) {
      checkComplete.add(sharedPreferences.getBool('Day $i - ${widget.plan}'));
    }

    return checkComplete;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('images/load.json'),
          const Center(
            child: Text(
              'Please Wait..',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const Center(
            child: Text(
              'We Are Getting Things Ready!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          )
        ],
      )),
    );
  }
}
