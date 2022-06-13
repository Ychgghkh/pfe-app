import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled19/constants.dart';

import '../../Services/AuthServices.dart';
import 'alertTask.dart';

class MySignUp extends StatefulWidget {
  const MySignUp({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MySignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController gsmController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "format incorrecte";
                                    } else
                                      return null;
                                  },
                                  controller: nameController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.account_circle),
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      hintText: "Nom d'utilisateur",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                ),
                                SizedBox(
                                  height: Constants.screenHeight * 0.01,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        (value.split("@")[1].split(".")[0] != "employee" &&
                                            value.split("@")[1].split(".")[0] != "president")) {
                                      return "format incorrecte";
                                    }
                                  },
                                  controller: emailcontroller,
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "format incorrecte";
                                    } else
                                      return null;
                                  },
                                  controller: gsmController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.call),
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      hintText: "Numero de telephone",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                ),
                                SizedBox(
                                  height: Constants.screenHeight * 0.01,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "format incorrecte";
                                    } else
                                      return null;
                                  },
                                  controller: passController,
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
                                SizedBox(
                                  height: Constants.screenHeight * 0.15,
                                ),
                                loading
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(top: Constants.screenHeight * 0.06),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Créer un compte',
                                              style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
                                            ),
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Color(0xff4c505b),
                                              child: IconButton(
                                                  color: Colors.white,
                                                  onPressed: () async {
                                                    if (_formkey.currentState!.validate()) {
                                                      setState(() {
                                                        loading = true;
                                                      });

                                                      bool check = await AuthServices().signUp(emailcontroller.text,
                                                          passController.text, nameController.text, gsmController.text);

                                                      if (check) {
                                                        setState(() {
                                                          loading = false;
                                                        });
                                                        alertTask(
                                                          lottieFile: "images/success.json",
                                                          action: "Terminé",
                                                          message: "Le compte a été créé avec succès",
                                                          press: () {
                                                            Get.back();
                                                          },
                                                        ).show(context);
                                                      } else {
                                                        setState(() {
                                                          loading = false;
                                                        });
                                                        alertTask(
                                                          lottieFile: "images/error.json",
                                                          action: "Ressayer",
                                                          message: "Email déja existe",
                                                          press: () {
                                                            Navigator.pop(context);
                                                          },
                                                        ).show(context);
                                                      }
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
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Icon(Icons.arrow_back_ios),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                      height: Constants.screenHeight * 0.08,
                      width: Constants.screenWidth * 0.15,
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
