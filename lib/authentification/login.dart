import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled19/consts/color.dart';
import 'package:untitled19/consts/global.dart';

import 'package:wave/config.dart';
import 'package:wave/wave.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _passwordFocusNode = FocusNode();

  bool _obscuretext=true;
  final _formkey =GlobalKey<FormState>();
  String  _emailAdress ='' ;
  String  _password ='' ;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final isValid = _formkey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if (isValid!) {
      setState(() {
        _isLoading = true;
      });
      _formkey.currentState?.save();
      try {
        await _auth
            .signInWithEmailAndPassword(
            email: _emailAdress.toLowerCase().trim(),
            password: _password.trim())
            .then((value) =>
        Navigator.canPop(context) ? Navigator.pop(context) : null);
      } catch (error) {
        _globalMethods.authErrorHandle(error.toString(), context);
        print('error occured ${error.toString()}');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.95,
              child: RotatedBox(
                quarterTurns: 2,
                child: WaveWidget(
                  config: CustomConfig(
                    gradients: [
                      [ColorsConsts.gradiendFStart, ColorsConsts.gradiendLStart],
                      [ColorsConsts.gradiendFEnd, ColorsConsts.gradiendLEnd],
                    ],
                    durations: [19440, 10800],
                    heightPercentages: [0.20, 0.25],
                    blur: MaskFilter.blur(BlurStyle.solid, 10),
                    gradientBegin: Alignment.bottomLeft,
                    gradientEnd: Alignment.topRight,
                  ),
                  waveAmplitude: 0,
                  size: Size(
                    double.infinity,
                    double.infinity,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 80),
                    height: 120.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      //  color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image:
                        AssetImage('images/login.png'),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    key:_formkey
                    ,child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Email'),
                          validator: (value) {
                            if (value!.isEmpty ) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            filled: true,
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Email Adress',
                            fillColor: Theme.of(context).backgroundColor,
                          ),
                          onSaved: (value){
                            _emailAdress = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Password'),
                          validator: (value) {
                            if (value!.isEmpty || value.length<7) {
                              return 'Please enter a valid password';
                            }
                            return null;
                          },

                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            filled: true,
                            prefixIcon: Icon(Icons.vpn_key),
                            suffixIcon: GestureDetector(onTap: (){
                              setState(() {
                                _obscuretext =!_obscuretext;

                              });
                            },
                              child: Icon(_obscuretext ? Icons.visibility
                                  :Icons.visibility_off),),
                            labelText: 'Password',
                            fillColor: Theme.of(context).backgroundColor,
                          ),
                          onSaved: (value){
                            _password = value!;
                          },
                          obscureText: _obscuretext,
                        ),
                      ),


                      Row(mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            SizedBox(width: 10,),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.purple) ,
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0),
                                      side: BorderSide(
                                          color: ColorsConsts.backgroundColor),),)),
                              onPressed: _submitForm,


                              child:  Row(
                                mainAxisAlignment : MainAxisAlignment.center,
                                children: [
                                  Text('Login',
                                    style: TextStyle(fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                  SizedBox(width: 5,),
                                  Icon(Icons.person ,size: 20,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20,)
                          ]

                      ),


                    ],

                  ),
                  ),

                ],
              ),
            ) ,],
        ) );
  }
}
