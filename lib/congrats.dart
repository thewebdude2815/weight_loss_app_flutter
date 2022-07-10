import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weight/choosePlan.dart';
import 'package:weight/homePage.dart';
import 'package:weight/loading_page.dart';
import 'package:weight/main.dart';

class Congrats extends StatelessWidget {
  const Congrats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Lottie.asset('images/congrats.json'),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return LoadingPage(
                  plan: planName,
                );
              }));
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
                'Back Home',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ],
      )),
    );
  }
}
