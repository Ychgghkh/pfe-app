import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

WillPopTitle(String title, BuildContext context) {
  return Column(
    children: [
      Image.asset("images/exclamation.png", height: Constants.screenHeight * 0.06, color: Color(0xff056CF2)),
      Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontFamily: "NunitoBold",
        ),
      ),
    ],
  );
}

Widget Positive(VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xff056CF2)),
      child: Container(
        height: 20,
        child: TextButton(
            onPressed: onPressed,
            child: Text(
              "Oui",
              style: TextStyle(
                fontFamily: "NunitoBold",
                color: Color(0xffEAEDEF),
              ),
            )),
      ),
    ),
  );
}

Widget Negative() {
  return Builder(builder: (context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff3dc295),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Non",
              style: TextStyle(
                fontFamily: "NunitoBold",
                color: Color(0xffEAEDEF),
              ),
            )),
      ),
    );
  });
}
