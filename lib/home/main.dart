import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../BottomNavi/BotttomNavigatorBar.dart';
import '../BottomNavi/profile/myblog_profile.dart';
import '../image_pick/image_uploading.dart';
import '../login/sign_inn.dart';
import '../login/sign_upp.dart';

import '../other/constants.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(MyApp());
}

String  CurrentUserEmail ='';
String  CurrentUserName ='';
String  CurrentUserID ='';
String  CurrentUserAbout ='';
String  CurrentUserImage ='';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kHomeBGColor,
        fontFamily: "Mulish",
      ),
      // home:BottomNavBar(0),
      home: Sign_in(),
      );
  }
}
