import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight/choosePlan.dart';
import 'package:weight/homePage.dart';
import 'package:weight/loading_page.dart';

void main() {
  runApp(const Weight());
}

String? planNameAvaliable;

class Weight extends StatefulWidget {
  const Weight({Key? key}) : super(key: key);

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      getPlanVerification().whenComplete(() {
        Get.to(planNameAvaliable == null
            ? Plan()
            : LoadingPage(
                plan: planNameAvaliable,
              ));
      });
    });
    super.initState();
  }

  Future getPlanVerification() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var receivedPlan = sharedPreferences.getString('planName');
    setState(() {
      planNameAvaliable = receivedPlan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          child: Lottie.asset('images/dumble.json'),
        ));
  }
}
