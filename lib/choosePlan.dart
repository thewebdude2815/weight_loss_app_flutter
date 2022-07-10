import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight/homePage.dart';
import 'package:weight/loading_page.dart';

import 'main.dart';

List<bool?> daysList = [];
String planName = 'beginner';

class Plan extends StatefulWidget {
  const Plan({Key? key}) : super(key: key);

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  addListBool() async {
    for (var i = 1; i < 31; i++) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setBool('Day $i - $planName', false);
      setState(() {
        daysList.add(false);
      });
    }
  }

  String? planTime;
  Color bgCb = Colors.white;
  Color bgCi = Colors.white;
  Color bgCa = Colors.white;
  @override
  void initState() {
    addListBool();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 64, 201, 255).withOpacity(0.7),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: new AssetImage('images/bg.jpg'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                const Text(
                  'CHOOSE YOUR PLAN',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Lose weight with the plan that suits you best',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                PlanWidget(
                    planLevel: 'BEGINNER',
                    time: "5-10",
                    bgColor: bgCb,
                    onTap: () {
                      setState(() {
                        planName = 'beginner';
                        planTime = '5-10';
                        bgCb = const Color.fromARGB(255, 59, 206, 255);
                        bgCi = Colors.white;
                        bgCa = Colors.white;
                      });
                    }),
                PlanWidget(
                    planLevel: 'INTERMEDIATE',
                    time: "10-15",
                    bgColor: bgCi,
                    onTap: () {
                      setState(() {
                        planName = 'intermediate';
                        planTime = '10-15';
                        bgCb = Colors.white;
                        bgCi = const Color.fromARGB(255, 59, 206, 255);
                        bgCa = Colors.white;
                      });
                    }),
                PlanWidget(
                    planLevel: 'ADVANCED',
                    time: "15-30",
                    bgColor: bgCa,
                    onTap: () {
                      setState(() {
                        planName = 'advanced';
                        planTime = '15-30';
                        bgCb = Colors.white;
                        bgCi = Colors.white;
                        bgCa = const Color.fromARGB(255, 59, 206, 255);
                      });
                    }),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () async {
                      addListBool();
                      final SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.setString('planName', planName);
                      Get.to(LoadingPage(
                        plan: planName,
                      ));
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 59, 206, 255),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PlanWidget extends StatelessWidget {
  String planLevel;
  String time;
  var onTap;
  Color bgColor;
  PlanWidget(
      {required this.planLevel,
      required this.time,
      required this.onTap,
      required this.bgColor});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
              color: bgColor, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                planLevel,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '$time mins a day',
                style: const TextStyle(
                    color: Color.fromARGB(255, 59, 59, 59), fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
