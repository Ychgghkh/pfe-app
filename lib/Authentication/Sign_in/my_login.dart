import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';
import 'package:untitled19/constants.dart';

import '../../Models/Users.dart';
import '../../Services/AuthServices.dart';
import '../../admin/admin_home.dart';
import '../../user/client_home_page.dart';
import '../../will_pop.dart';
import '../Forgot_password/forgotpass.dart';
import '../on_boarding_controller.dart';
import 'components/infoMessage.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  OnBoardingController controller = OnBoardingController();
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

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: avoidReturnButton,
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('images/login.png'), fit: BoxFit.cover),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Container(),
                  Container(
                    padding: EdgeInsets.only(left: 35, top: 130),
                    child: Text(
                      'Bienvenue',
                      style: TextStyle(color: Colors.white, fontSize: 33),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 35, right: 35),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: emailController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Champ obligatoire";
                                      } else
                                        return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.email),
                                        fillColor: Colors.grey.shade100,
                                        filled: true,
                                        hintText: "Email",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        )),
                                  ),
                                  SizedBox(
                                    height: Constants.screenHeight * 0.01,
                                  ),
                                  TextFormField(
                                    controller: passwordController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Champ obligatoire";
                                      }
                                    },
                                    style: TextStyle(),
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.lock),
                                        fillColor: Colors.grey.shade100,
                                        filled: true,
                                        hintText: "Mot de passe",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        )),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                        onPressed: () {
                                          Get.to(ForgotPassScreen());
                                        },
                                        child: const Text(
                                          'Mot de passe oublié ?',
                                          style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            color: Colors.blueAccent,
                                            fontSize: 18,
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    height: Constants.screenHeight * 0.23,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: Constants.screenHeight * 0.06),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Connectez-vous',
                                          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
                                        ),
                                        isLoading
                                            ? CircularProgressIndicator()
                                            : CircleAvatar(
                                                radius: 30,
                                                backgroundColor: Color(0xff4c505b),
                                                child: IconButton(
                                                    color: Colors.white,
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
                                                            var UserData = await FirebaseFirestore.instance
                                                                .collection('users')
                                                                .doc(uid)
                                                                .get();

                                                            if (Cusers.fromJson(UserData.data() as Map<String, dynamic>)
                                                                    .email
                                                                    .split("@")[1]
                                                                    .split(".")[0] ==
                                                                "president") {
                                                              // test de role
                                                              await controller.RememberUser(
                                                                  UserData.data() as Map<String, dynamic>,
                                                                  1); //.data() pour recuperer le donneées de document
                                                              Get.to(AdminHomePage());
                                                            } else if (Cusers.fromJson(UserData.data() as Map<String, dynamic>)
                                                                    .email
                                                                    .split("@")[1]
                                                                    .split(".")[0] ==
                                                                "employee") {
                                                              await controller.RememberUser(
                                                                  UserData.data() as Map<String, dynamic>,
                                                                  2); //.data() pour recuperer le donneées de document
                                                              Get.to(ClientHomePage());
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
                                                    },
                                                    icon: Icon(
                                                      Icons.arrow_forward,
                                                    )),
                                              )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
