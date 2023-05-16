import 'dart:async';


import 'package:copyfile/home_buttons.dart';
import 'package:copyfile/ui/auth/login_screeen.dart';
import 'package:copyfile/ui/firestore/firestore_list_screen.dart';
import 'package:copyfile/ui/uplode_image.dart';
import 'package:copyfile/user_corent_location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SplashServices{

  void isLogin(BuildContext context){

    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if(user != null) {
      Timer(
          const Duration(seconds: 1),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeButtons())));
    }else{
      Timer(
          const Duration(seconds: 1),
              () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen())));

    }



  }
}