import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled19/consts/color.dart';
import 'package:untitled19/consts/global.dart';

import 'package:wave/config.dart';
import 'package:wave/wave.dart';
class SignUp extends StatefulWidget {
  static const routeName='\SignUp';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  bool _obscuretext=true;
  final _formkey =GlobalKey<FormState>();
  final FirebaseAuth _auth =FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();
  bool _isloading =false;
  String  _emailAdress ='' ;
  String  _password ='' ;
  String  _fullname ='' ;
  late int _phonenumber;
  File _pickedImage =new File('');
  late String url;
  @override
  void dispose(){
    _emailFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _passwordFocusNode.dispose();
  }
  void _submitform() async{
    final isvalid =_formkey.currentState?.validate();
    FocusScope.of(context).unfocus();
    var date =DateTime.now().toString();
    var dateparse= DateTime.parse(date);
    var formattedDate = "${dateparse.day}-${dateparse.month}-${dateparse.year}";

    if(isvalid!){

      _formkey.currentState?.save();
      try {
        if(_pickedImage ==null)
        {
          _globalMethods.authErrorHandle('Please pick an image', context);

        }
        else {
          setState(() {
            _isloading=true;
          });
          final ref = FirebaseStorage.instance
              .ref()
              .child('usersImages')
              .child(_fullname + '.jpg');
          await ref.putFile(_pickedImage);
          url = await ref.getDownloadURL();
          await _auth.createUserWithEmailAndPassword(email: _emailAdress.toLowerCase().trim(), password: _password.trim());
          final User? user = _auth.currentUser;
          final _uid =user!.uid;
          await   FirebaseFirestore.instance.collection('users').doc(_uid).set({
            'id' :_uid,
            'name':_fullname,
            'email':_emailAdress,
            'phonenumber':_phonenumber,
            'imageUrl':url,
            'joinedAt':formattedDate,
            'created':Timestamp.now(),
          });
          Navigator.canPop(context) ?Navigator.pop(context):null;
        }



      } catch(error){
        _globalMethods.authErrorHandle(error.toString(), context);
        print('Error occured:${error.toString()}');
      }
      setState(() {
        _isloading=false;
      });
    }
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 10);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }
  void _remove() {
    setState(() {
      _pickedImage = null! ;
    });
    Navigator.pop(context);
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
              child: Column(children: [
                SizedBox(height: 30,
                ),
                Stack(children: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 30,horizontal: 30,
                      ),
                      child:CircleAvatar(radius: 71,backgroundColor: ColorsConsts.gradiendFEnd,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: _pickedImage ==null ?null
                              :FileImage(_pickedImage),
                        ),)
                  ),
                  Positioned(top: 120
                      ,left: 120,
                      child: RawMaterialButton(
                        elevation: 10,
                        fillColor: ColorsConsts.gradiendLEnd,
                        child: Icon(Icons.add_a_photo),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                        onPressed: (){
                          showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              title: Text('Choose an option',
                                style: TextStyle(fontWeight: FontWeight.w600,
                                    color: ColorsConsts.gradiendLStart),),
                              content:SingleChildScrollView(
                                child: ListBody(
                                  children: [
                                    InkWell(onTap: _pickImageCamera,
                                      splashColor:
                                      Colors.purpleAccent ,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.camera,
                                              color: Colors.purpleAccent,),
                                          ),
                                          Text(
                                            'Camera',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight:
                                                FontWeight.w500,
                                                color:
                                                ColorsConsts.title),
                                          )

                                        ],
                                      ),),
                                    InkWell(onTap: _pickImageGallery,
                                      splashColor:
                                      Colors.purpleAccent ,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.image,
                                              color: Colors.purpleAccent,),
                                          ),
                                          Text(
                                            'Gallery',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight:
                                                FontWeight.w500,
                                                color:
                                                ColorsConsts.title),
                                          )

                                        ],
                                      ),),
                                    InkWell(onTap: _remove,
                                      splashColor:
                                      Colors.purpleAccent ,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.remove,
                                              color: Colors.red,),
                                          ),
                                          Text(
                                            'Remove',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight:
                                                FontWeight.w500,
                                                color:
                                                Colors.red),
                                          )

                                        ],
                                      ),)
                                  ],
                                ),
                              ),
                            );
                          }
                          );
                        },

                      ))
                ],),


                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('name'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'name cannot be null';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,

                          onEditingComplete: _submitform,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.person),
                              labelText: 'Full name',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _fullname = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('email'),
                          focusNode: _emailFocusNode,
                          validator: (value) {
                            if   (value!.isEmpty) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_emailFocusNode),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.email),
                              labelText: 'Email Address',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _emailAdress = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Password'),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return 'the password must exceed seven characters';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          focusNode: _passwordFocusNode,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscuretext = !_obscuretext;
                                  });
                                },
                                child: Icon(_obscuretext
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              labelText: 'Password',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _password = value! ;
                          },
                          obscureText: _obscuretext,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_phoneNumberFocusNode),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('phone number'),
                          focusNode: _phoneNumberFocusNode,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputAction: TextInputAction.next,
                          onEditingComplete: _submitform,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.phone_android),
                              labelText: 'Phone number',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _phonenumber= int.parse(value!);
                          },
                        ),
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            SizedBox(width: 10,),
                            _isloading ? CircularProgressIndicator():
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.purple) ,
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0),
                                      side: BorderSide(
                                          color: ColorsConsts.backgroundColor),
                                    ),
                                  )
                              ),
                              onPressed: _submitform,
                              child:  Row(
                                mainAxisAlignment : MainAxisAlignment.center,
                                children: [
                                  Text('Sign up',
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
            ),
          ],
        ) );
  }
}
