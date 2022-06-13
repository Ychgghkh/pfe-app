import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants.dart';

InkWell buildGridItem(String navigationRoute, String image, String label) {
  return InkWell(
    onTap: () {
      Get.toNamed("$navigationRoute");
    },
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.06, vertical: Constants.screenHeight * 0.01),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        height: Constants.screenHeight * 0.1,
        child: ListTile(
          title: Row(
            children: [
              Container(
                height: Constants.screenHeight * 0.06,
                decoration: BoxDecoration(color: Color(0xff056CF2).withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "${image}",
                    color: Color(0xff056CF2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${label}",
                  style: TextStyle(
                      /*    color: Color(0xff5686E1),*/
                      fontFamily: "NunitoBold",
                      color: Color(0xff056CF2),
                      fontSize: Constants.screenHeight * 0.02),
                ),
              )
            ],
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Color(0xff056CF2),
          ),
        ),
      ),
    ),
  );
}
