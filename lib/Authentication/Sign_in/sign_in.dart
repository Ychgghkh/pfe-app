import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Models/Users.dart';
import '../../Services/AuthServices.dart';
import '../Forgot_password/forgotpass.dart';
import '../Sign_up/signup.dart';
import '../on_boarding_controller.dart';
import 'components/infoMessage.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignInScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  OnBoardingController controller = OnBoardingController();

  Future<bool> avoidReturnButton() async {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text("vous etes sur de sortir ?"),
            actions: [Negative(context), Positive()],
          );
        });
    return true;
  }

  Widget Positive() {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: TextButton(
          onPressed: () {
            exit(0);
          },
          child: const Text(
            " Oui",
            style: TextStyle(
              color: Color(0xffEAEDEF),
            ),
          )),
    );
  } // fermeture de l'application

  Widget Negative(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context); // fermeture de dialog
        },
        child: Text(" Non"));
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: avoidReturnButton,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
                key: _formkey,
                child: Column(children: [
                  Container(
                    height: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(90),
                      ),
                      gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
                        Colors.blueGrey,
                        Colors.indigo,
                      ]),
                    ),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Image(
                            image: AssetImage('images/camping.png'),
                            height: 100,
                            width: 100,
                          ),
                        ),
                        // SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            'Se Connecter ',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                //  fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        )
                      ],
                    )),
                  ),
                  SizedBox(height: 80),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 6),
                      ),
                    ]),
                    height: 50,
                    child: TextFormField(
                      controller: emailController,
                      validator: (Value) {
                        if (Value!.isEmpty) return "s'il vous plait saisir un email valide ";
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14),
                        prefixIcon: Icon(Icons.email, color: Colors.indigo),
                        hintText: 'exemple@gmail.com',
                        hintStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 6),
                      ),
                    ]),
                    height: 50,
                    child: TextFormField(
                      controller: passwordController,
                      validator: (Value) {
                        if (Value!.isEmpty) return "s'il vous plait saisir un mot de passe valide ";
                      },
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.indigo,
                        ),
                        hintText: 'Mot de passe',
                        hintStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(ForgotPassScreen());
                      },
                      child: Text(
                        "mot de passe oublié?",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black54,
                            //fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  isLoading
                      ? CircularProgressIndicator()
                      : Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                  child: CupertinoButton(
                                      child:
                                          Text('Connexion', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic)),
                                      color: Colors.indigo,
                                      onPressed: () {
                                        if (_formkey.currentState!.validate()) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          AuthServices()
                                              .signIn(emailController.text, passwordController.text)
                                              .then((value) async {
                                            if (value) {
                                              final FirebaseAuth auth = await FirebaseAuth.instance;
                                              final User? user = await auth.currentUser;
                                              final uid = user!.uid;
                                              var UserData = await FirebaseFirestore.instance.collection('users').doc(uid).get();

                                              if (Cusers.fromJson(UserData.data() as Map<String, dynamic>)
                                                      .email
                                                      .split("@")[1]
                                                      .split(".")[0] ==
                                                  "president") {
                                                await controller.RememberUser(UserData.data() as Map<String, dynamic>,
                                                    1); //.data() pour recuperer le donneées de document
                                                // Get.to(HomePageAdmin());
                                              } else if (Cusers.fromJson(UserData.data() as Map<String, dynamic>)
                                                      .email
                                                      .split("@")[1]
                                                      .split(".")[0] ==
                                                  "employee") {
                                                await controller.RememberUser(UserData.data() as Map<String, dynamic>,
                                                    2); //.data() pour recuperer le donneées de document
                                                // Get.to(HomePageClient());
                                              }
                                              setState(() {
                                                isLoading = false;
                                              });
                                            } else {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              InfoMessage(
                                                press: () {
                                                  Get.back();
                                                },
                                                lottieFile: "images/error.json",
                                                action: "Ressayer",
                                                message: "Merci de vierfier vos données ",
                                              ).show(context);
                                            }
                                          });
                                        }
                                      }))
                            ],
                          )),
                  SizedBox(height: 20),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextButton(
                            child: Text("Besoin d'un nouveau compte?",
                                style: TextStyle(color: Colors.indigo, fontSize: 14, fontStyle: FontStyle.italic)),
                            onPressed: () {
                              Get.to(SignupScreen());
                            },
                          ))
                        ],
                      )),
                ])),
          )),
    );
  }
}
