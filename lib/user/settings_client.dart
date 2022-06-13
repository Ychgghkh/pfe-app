import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

import '../Authentication/on_boarding_controller.dart';
import '../constants.dart';
import '../will_pop.dart';

class SettingsClient extends StatefulWidget {
  const SettingsClient({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsClient> {
  OnBoardingController controller = OnBoardingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: Constants.screenHeight * 0.2,
                ),
                SizedBox(
                  height: Constants.screenHeight * 0.03,
                ),
                GestureDetector(
                  onTap: () {
                    NAlertDialog(
                      title: WillPopTitle("Voulez vous deconnecter ?", context),
                      actions: [
                        Negative(),
                        Positive(() {
                          controller.Logout();
                        })
                      ],
                      blur: 2,
                    ).show(context, transitionType: DialogTransitionType.Bubble);
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                        ),
                        Text("Deconnecter", style: TextStyle(color: Colors.white, fontSize: 20)),
                      ],
                    ),
                    height: Constants.screenHeight * 0.1,
                    decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(15)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
