import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constants.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  List listOfFingers = [];
  List<ChartData> dataSource = [
    ChartData('0', 0, Colors.blueAccent),
    ChartData('1', 0, Color.fromRGBO(9, 0, 136, 1)),
    ChartData('2', 0, Colors.redAccent),
    ChartData('3', 0, Colors.green),
    ChartData('4', 0, Color.fromRGBO(255, 189, 57, 1)),
    ChartData('5', 0, Colors.cyanAccent),
  ];
  _getScreenList() {
    var screenReference = FirebaseDatabase.instance.ref().child("fingers");
    screenReference.onValue.listen((event) {
      listOfFingers.clear();
      var map = event.snapshot.value as List;
      for (var i = 0; i < map.length; i++) {
        dataSource[i].y = int.parse(map[i]);
      }

      setState(() {});
    });
  }

  bool isVisible = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getScreenList();
    Future.delayed(Duration(seconds: 3), () {
      if (this.mounted) {
        setState(() {
          isVisible = false;
        });
      }
    });
  }

  var user = GetStorage().read("user");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            height: Constants.screenHeight * 0.3,
            decoration: const BoxDecoration(
                color: Color(0xff056CF2),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(110), bottomRight: Radius.circular(0), bottomLeft: Radius.circular(110))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                          child: Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        height: Constants.screenHeight * 0.08,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image.asset("images/avatar.png"),
                        ),
                      )),
                    ),
                    Container(
                      height: Constants.screenHeight * 0.15,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: Constants.screenHeight * 0.2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bienvenue",
                                    style: TextStyle(
                                        fontFamily: "NunitoBold", fontSize: Constants.screenHeight * 0.03, color: Colors.white),
                                  ),
                                  Text(
                                    "${user["userName"]}",
                                    style: TextStyle(
                                        fontFamily: "NunitoBold", fontSize: Constants.screenHeight * 0.02, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Visibility(
                                visible: isVisible,
                                child: Container(
                                  child: Lottie.asset("images/hello.json",
                                      repeat: false, height: Constants.screenHeight * 0.2, width: Constants.screenWidth * 0.3),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Text(
            "Statistiques de nombre de doigts",
            style: TextStyle(
              fontFamily: "NunitoBold",
              color: Color(0xff056CF2),
              fontSize: Constants.screenHeight * 0.02,
            ),
          ),
          SfCircularChart(legend: Legend(isVisible: true), series: <CircularSeries>[
            // Renders doughnut chart

            DoughnutSeries<ChartData, String>(
                dataSource: dataSource,
                dataLabelSettings: DataLabelSettings(labelPosition: ChartDataLabelPosition.outside, isVisible: true),
                pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y),
          ]),
        ],
      ),
    ));
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  String x;
  int y;
  Color color;
}
