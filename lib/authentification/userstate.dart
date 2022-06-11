import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled19/authentification/bottom.dart';
import 'package:untitled19/authentification/login.dart';
import 'package:untitled19/home.dart';

class UserState extends StatelessWidget {
  @override
  final Future<FirebaseApp> _Initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: _Initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(body: Center(
            child: Text("Error:${snapshot.hasError}"),
          ),
          );
        }
        if(snapshot.connectionState == ConnectionState.done){
          return StreamBuilder(
            stream:FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.active) {
                Object? user = snapshot.data;
                if (user == null) {

                  return HomePage();
                }
                else {
                  return HomePage();
                }
              }
              return Scaffold(
                body: Center(
                  child: Text("cheking login"),
                ),
              );
            },
          );
        }
        return Scaffold(
          body: Center(
            child: Text("cheking authentification"),
          ),
        );
      },
    );
  }
}
