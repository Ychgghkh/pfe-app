import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:untitled19/Authentication/Sign_in/my_login.dart';

import '../../Services/AuthServices.dart';
import '../../constants.dart';
import '../Sign_up/alertTask.dart';

//import 'homescreen.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  _ForgotPassScreenState createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  TextEditingController emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/login.png'), fit: BoxFit.cover),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 35, right: 35),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: emailController,
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
                                  height: Constants.screenHeight * 0.05,
                                ),
                                loading
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Container(
                                        height: Constants.screenHeight * 0.06,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (_formkey.currentState!.validate()) {
                                              setState(() {
                                                loading = true;
                                              });
                                              AuthServices().resetPassword(emailController.text).then((value) {
                                                setState(() {
                                                  loading = false;
                                                });
                                                if (value) {
                                                  alertTask(
                                                    lottieFile: "images/success.json",
                                                    action: "Connecter",
                                                    message: "Consultez vos mail svp",
                                                    press: () {
                                                      Get.to(() => MyLogin());
                                                    },
                                                  ).show(context);
                                                } else {
                                                  alertTask(
                                                    lottieFile: "images/error.json",
                                                    action: "Ressayer",
                                                    message: "compte n'existe pas ",
                                                    press: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ).show(context);
                                                }
                                              });
                                            }
                                          },
                                          child: Text("Réinitialiser le mot de passe"),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Icon(Icons.arrow_back_ios),
                      height: Constants.screenHeight * 0.08,
                      width: Constants.screenWidth * 0.17,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
