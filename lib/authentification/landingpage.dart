import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled19/authentification/signup.dart';
import 'package:untitled19/authentification/userstate.dart';
import 'package:untitled19/consts/color.dart';
import 'package:untitled19/consts/global.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with TickerProviderStateMixin {
 late   AnimationController _animationController;
  late  Animation<double> _animation;
 List<String> images = [
   'https://www.nbaconseil.fr/pub/images/satisfaction-client.jpg',
   'https://www.intelrealsense.com/wp-content/uploads/2020/01/hand_tracking_and_gesture_recognition.jpg',
   'https://www.codeur.com/blog/wp-content/uploads/2018/10/codeur-mag-mesurer-satisfaction-client.png',
   'https://wp-medias-solutions.lesechos.fr/2017/07/enq%C3%AAtedesatisfaction-scaled.jpg',
 ];
 final FirebaseAuth _auth = FirebaseAuth.instance;
 GlobalMethods _globalMethods = GlobalMethods();
 @override
 void initState(){
     super.initState();
     images.shuffle();
     _animationController =AnimationController(vsync: this,duration: Duration(seconds: 20));
     _animation =CurvedAnimation(parent: _animationController, curve: Curves.linear)
     ..addListener(() { setState(() {

     });})..addStatusListener((animationstatus) {
       if(animationstatus == AnimationStatus.completed){
         _animationController.reset();
         _animationController.forward();
     }
     });
_animationController.forward();
   }
 void  dispose(){
     _animationController.dispose();
     super.dispose();
   }


   @override

 Widget build(BuildContext context) {

      return Scaffold(body:
      (
    Stack(children: [
      CachedNetworkImage(imageUrl:
        images[3],
      errorWidget: (context,url,error)=>Icon(Icons.error,),
        fit:BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: FractionalOffset(_animation.value,0),
      ),
      Container(
         margin: EdgeInsets.only(top :30),
        width: double.infinity,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Text('Welcome',
         style: TextStyle(fontSize: 40,
         fontWeight: FontWeight.w600),),
         SizedBox(height: 20,
         ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 30),
           child: Text('Welcome to our municipality',
        textAlign: TextAlign.center,
             style: TextStyle(
               fontSize: 26,
               fontWeight: FontWeight.w400
             ),
           ),
         ),
       ],
  ),
),
      Column(mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(children: [
            SizedBox(width: 10,),
           Expanded(
           child: ElevatedButton(
             style: ButtonStyle(
                 backgroundColor:MaterialStateProperty.all(Colors.grey) ,
                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                 RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0),
                 side: BorderSide(
                     color: ColorsConsts.backgroundColor),),)),
               onPressed: (){
                 Navigator.push(context,
                   MaterialPageRoute(
                     builder:(context)=>UserState(),),);
               }, 
               child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
                 Text('Admin',
             style: TextStyle(fontWeight: FontWeight.w500,
          fontSize: 17),
        ),
         SizedBox(width: 5,),
     Icon(Icons.person ,size: 20,
    ),
    ],
    ),

    ),
           ),

            Expanded(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:MaterialStateProperty.all(Colors.grey) ,
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0),
                      side: BorderSide(
                          color: ColorsConsts.backgroundColor),),)),
                  onPressed: (){
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder:(context)=>SignUp(),),);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('User',
                        style: TextStyle(fontWeight: FontWeight.w500,
                          fontSize: 17),
                      ),
                      SizedBox(width: 5,),
                      Icon(Icons.person_add_sharp ,size: 20,
                      ),
                    ],
                  ),

              ),

            ),
          ],),
          SizedBox(height: 10,),
          Row(children: [
            Expanded(child:
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: Colors.white,
                thickness: 2,
              ),
            )
            ),




          ],
          ),

        ],
      ),

    ],)
    ),);
  }
}
