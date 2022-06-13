import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled19/Authentication/Sign_in/my_login.dart';
import 'package:untitled19/admin/admin_home.dart';
import 'package:untitled19/user/client_home_page.dart';

import '../constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var auth = GetStorage().read("auth");

  var type_auth = GetStorage().read("type_auth");

  @override
  void initState() {
    super.initState();
    var timer =
        Timer(Duration(seconds: 3), () => Get.to(auth == 1 ? (type_auth == 1 ? AdminHomePage() : ClientHomePage()) : MyLogin()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
                Colors.indigo,
                Colors.blueGrey,
              ]),
            ),
            child: Column(children: <Widget>[
              SizedBox(
                height: size.height * 0.2,
              ),
              Lottie.asset("images/splash.json", height: Constants.screenHeight * 0.1),
              SizedBox(
                height: size.height * 0.1,
              ),
              Text(
                Constants.HomeText,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Lottie.asset("images/loading.json", height: Constants.screenHeight * 0.07),
            ])));
  }
}
