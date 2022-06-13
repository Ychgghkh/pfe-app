import 'dart:io';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:untitled19/admin/home.dart';
import 'package:untitled19/admin/settings.dart';

import '../will_pop.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  _AdminHomePgaeState createState() => _AdminHomePgaeState();
}

class _AdminHomePgaeState extends State<AdminHomePage> {
  Future<bool> avoidReturnButton() async {
    NAlertDialog(
      title: WillPopTitle("Voulez vous quitter ?", context),
      actions: [
        Negative(),
        Positive(() {
          exit(0);
        })
      ],
      blur: 2,
    ).show(context, transitionType: DialogTransitionType.Bubble);
    return true;
  }

  int _selectedIndex = 0;
  List pages = [HomeAdmin(), SettingsAdmin()];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: avoidReturnButton,
      child: SafeArea(
        child: Scaffold(
            body: pages[_selectedIndex],
            bottomNavigationBar: BottomNavyBar(
              selectedIndex: _selectedIndex,
              showElevation: true,
              onItemSelected: (index) => setState(() {
                _selectedIndex = index;
              }),
              items: [
                BottomNavyBarItem(icon: Icon(Icons.home), title: Text('Acceuil'), activeColor: Colors.pink),
                BottomNavyBarItem(icon: Icon(Icons.settings), title: Text('Parametres'), activeColor: Colors.blue),
              ],
            )),
      ),
    );
  }
}
